import cv2
import numpy as np
from typing import List, Tuple, Optional, Dict
import os
import sys

# Import Inference Pipeline
try:
    from inference import InferencePipeline
    INFERENCE_AVAILABLE = True
    print("✅ Inference Pipeline available")
except ImportError:
    INFERENCE_AVAILABLE = False
    print("❌ Inference Pipeline not available. Install with: pip install inference")

class InferencePlayerDetector:
    """Inference Pipeline-based hockey player detector using custom trained model"""
    
    def __init__(self, api_key: str, workspace_name: str, workflow_id: str):
        self.api_key = api_key
        self.workspace_name = workspace_name
        self.workflow_id = workflow_id
        self.pipeline = None
        
        if INFERENCE_AVAILABLE:
            self._initialize_inference()
    
    def _initialize_inference(self):
        """Initialize Inference Pipeline connection"""
        try:
            print(f"🚀 Initializing Inference Pipeline...")
            print(f"   API Key: {self.api_key[:8]}...")
            print(f"   Workspace: {self.workspace_name}")
            print(f"   Workflow: {self.workflow_id}")
            
            # Initialize the pipeline
            self.pipeline = InferencePipeline.init_with_workflow(
                api_key=self.api_key,
                workspace_name=self.workspace_name,
                workflow_id=self.workflow_id,
                video_reference=0,  # We'll override this for each detection
                max_fps=30,
                on_prediction=self._handle_prediction
            )
            
            print(f"✅ Inference Pipeline initialized successfully!")
            
        except Exception as e:
            print(f"❌ Failed to initialize Inference Pipeline: {e}")
            INFERENCE_AVAILABLE = False
    
    def _handle_prediction(self, result, video_frame):
        """Handle prediction results from the inference pipeline"""
        self.last_prediction = result
        if hasattr(video_frame, 'numpy_image'):
            self.last_frame = video_frame.numpy_image
        else:
            self.last_frame = video_frame
    
    def detect_players_in_frame(self, frame: np.ndarray) -> List[Dict]:
        """
        Detect hockey players in a single frame using Inference Pipeline
        
        Args:
            frame: OpenCV frame (BGR format)
            
        Returns:
            List of player detections with bounding boxes and confidence scores
        """
        if not INFERENCE_AVAILABLE:
            print("❌ Inference Pipeline not available")
            return []
        
        try:
            # Save frame temporarily
            temp_path = "temp_frame.jpg"
            cv2.imwrite(temp_path, frame)
            
            print(f"🎯 Calling Roboflow model for frame detection...")
            print(f"   API Key: {self.api_key[:8]}...")
            print(f"   Workspace: {self.workspace_name}")
            print(f"   Workflow: {self.workflow_id}")
            
            # FAST METHOD: Use direct API call instead of pipeline for single frame
            try:
                from inference import get_model
                
                # Get the model directly (much faster than pipeline)
                model = get_model(
                    model_id=f"{self.workspace_name}/{self.workflow_id}",
                    api_key=self.api_key
                )
                
                print(f"🚀 Using direct model inference (faster)...")
                
                # Predict on the frame directly
                result = model.infer(temp_path, confidence=0.3, overlap=0.5)
                
                if result and hasattr(result, 'predictions'):
                    print(f"✅ Got direct prediction result")
                    players = self._extract_players_from_prediction(result)
                    print(f"🎯 Extracted {len(players)} players from prediction")
                    
                    # Clean up temp file
                    if os.path.exists(temp_path):
                        os.remove(temp_path)
                    
                    return players
                else:
                    print("⚠️  No predictions from direct model")
                    return []
                    
            except Exception as e:
                print(f"⚠️  Direct model inference failed: {e}")
                print("   Trying fallback method...")
                return self._fallback_detection(temp_path)
            
        except Exception as e:
            print(f"❌ Inference detection error: {e}")
            return []
    
    def detect_players_in_video(self, video_path: str, max_fps: int = 30) -> List[Dict]:
        """
        Detect hockey players throughout a video
        
        Args:
            video_path: Path to video file
            max_fps: Maximum FPS for processing
            
        Returns:
            List of player detections with frame information
        """
        if not INFERENCE_AVAILABLE or not self.pipeline:
            return []
        
        try:
            cap = cv2.VideoCapture(video_path)
            fps = cap.get(cv2.CAP_PROP_FPS)
            total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
            
            # Calculate frame skip for desired FPS
            frame_skip = max(1, int(fps / max_fps))
            
            print(f"🎬 Processing video: {fps:.1f} FPS, {total_frames} frames, processing every {frame_skip} frames")
            
            detections = []
            frame_count = 0
            processed_count = 0
            
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break
                
                frame_count += 1
                
                # Process every nth frame based on desired FPS
                if frame_count % frame_skip == 0:
                    players = self.detect_players_in_frame(frame)
                    
                    if players:
                        detections.append({
                            'frame': frame_count,
                            'players': players
                        })
                    
                    processed_count += 1
                    if processed_count % 10 == 0:
                        print(f"📊 Processed {processed_count} frames, found {len(detections)} detection frames")
            
            cap.release()
            print(f"✅ Video processing complete: {len(detections)} detection frames")
            return detections
            
        except Exception as e:
            print(f"❌ Video processing error: {e}")
            return []
    
    def get_player_bounding_boxes(self, frame: np.ndarray) -> List[List[int]]:
        """
        Get list of bounding boxes for player selection modal
        
        Args:
            frame: OpenCV frame
            
        Returns:
            List of bounding boxes in [x, y, w, h] format
        """
        players = self.detect_players_in_frame(frame)
        return [player['bbox'] for player in players]
    
    def track_player_across_frames(self, video_path: str, initial_bbox: List[int], max_fps: int = 30) -> List[Dict]:
        """
        Track a specific player across video frames using Inference Pipeline detection
        
        Args:
            video_path: Path to video file
            initial_bbox: Initial bounding box [x, y, w, h]
            max_fps: Maximum FPS for processing
            
        Returns:
            List of tracked positions and detections
        """
        if not INFERENCE_AVAILABLE or not self.pipeline:
            return []
        
        try:
            cap = cv2.VideoCapture(video_path)
            fps = cap.get(cv2.CAP_PROP_FPS)
            total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
            
            # Calculate frame skip for desired FPS
            frame_skip = max(1, int(fps / max_fps))
            
            print(f"🎯 Tracking player across video: {fps:.1f} FPS, {total_frames} frames")
            
            tracking_data = []
            frame_count = 0
            processed_count = 0
            
            # Calculate initial center
            init_x, init_y, init_w, init_h = initial_bbox
            init_center = (init_x + init_w/2, init_y + init_h/2)
            
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break
                
                frame_count += 1
                
                # Process every nth frame based on desired FPS
                if frame_count % frame_skip == 0:
                    players = self.detect_players_in_frame(frame)
                    
                    # Find closest player to initial position
                    best_player = None
                    min_distance = float('inf')
                    
                    for player in players:
                        player_center = player['center']
                        distance = np.sqrt((player_center[0] - init_center[0])**2 + 
                                        (player_center[1] - init_center[1])**2)
                        
                        if distance < min_distance:
                            min_distance = distance
                            best_player = player
                    
                    if best_player:
                        tracking_data.append({
                            'frame': frame_count,
                            'bbox': best_player['bbox'],
                            'center': best_player['center'],
                            'confidence': best_player['confidence']
                        })
                    
                    processed_count += 1
                    if processed_count % 10 == 0:
                        print(f"📊 Tracking: {processed_count} frames, {len(tracking_data)} detections")
            
            cap.release()
            print(f"✅ Player tracking complete: {len(tracking_data)} tracked frames")
            return tracking_data
            
        except Exception as e:
            print(f"❌ Player tracking error: {e}")
            return []
    
    def _extract_players_from_prediction(self, prediction_result) -> List[Dict]:
        """Extract player detections from Inference Pipeline prediction result"""
        players = []
        
        try:
            # Handle different prediction result formats
            if isinstance(prediction_result, dict):
                # Direct dictionary result
                predictions_data = prediction_result
            elif hasattr(prediction_result, 'json'):
                # Object with json method
                predictions_data = prediction_result.json()
            elif hasattr(prediction_result, '__dict__'):
                # Object with dict attributes
                predictions_data = prediction_result.__dict__
            else:
                print(f"⚠️  Unknown prediction result format: {type(prediction_result)}")
                return []
            
            # Look for predictions in different possible locations
            predictions = None
            if 'predictions' in predictions_data:
                predictions = predictions_data['predictions']
            elif 'data' in predictions_data:
                predictions = predictions_data['data']
            elif 'results' in predictions_data:
                predictions = predictions_data['results']
            elif 'output' in predictions_data:
                predictions = predictions_data['output']
            
            if predictions:
                for pred in predictions:
                    # Filter for player class (adjust class name as needed)
                    if pred.get('class') == 'player' or pred.get('class') == 'person':
                        x = pred.get('x', 0)
                        y = pred.get('y', 0)
                        width = pred.get('width', 0)
                        height = pred.get('height', 0)
                        confidence = pred.get('confidence', 0.5)
                        
                        # Convert to OpenCV format [x, y, w, h]
                        bbox = [int(x - width/2), int(y - height/2), int(width), int(height)]
                        
                        players.append({
                            'bbox': bbox,
                            'confidence': confidence,
                            'center': (int(x), int(y))
                        })
                        
                        print(f"🎯 Detected player: bbox={bbox}, confidence={confidence:.2f}")
            
        except Exception as e:
            print(f"❌ Error extracting players from prediction: {e}")
        
        return players
    
    def _fallback_detection(self, image_path: str) -> List[Dict]:
        """Fallback detection method using direct API call"""
        try:
            print("🔄 Using fallback detection method...")
            
            # Try to use the pipeline's direct predict method if available
            if hasattr(self.pipeline, 'predict'):
                print(f"   Using pipeline.predict() method...")
                result = self.pipeline.predict(image_path)
                print(f"   Prediction result type: {type(result)}")
                return self._extract_players_from_prediction(result)
            else:
                print("⚠️  No pipeline.predict() method available")
                print("   Trying alternative approach...")
                
                # Try to create a new pipeline instance for this specific prediction
                try:
                    print(f"   Creating new pipeline instance for fallback...")
                    fallback_pipeline = InferencePipeline.init_with_workflow(
                        api_key=self.api_key,
                        workspace_name=self.workspace_name,
                        workflow_id=self.workflow_id,
                        video_reference=image_path,
                        max_fps=1,
                        on_prediction=self._handle_prediction
                    )
                    
                    fallback_pipeline.start()
                    time.sleep(2)
                    fallback_pipeline.stop()
                    
                    if hasattr(self, 'last_prediction') and self.last_prediction:
                        print(f"   Fallback pipeline got prediction: {type(self.last_prediction)}")
                        return self._extract_players_from_prediction(self.last_prediction)
                    else:
                        print("   Fallback pipeline got no prediction")
                        return []
                        
                except Exception as fallback_e:
                    print(f"   Fallback pipeline failed: {fallback_e}")
                    return []
                
        except Exception as e:
            print(f"❌ Fallback detection failed: {e}")
            return []

# Global detector instance
inference_detector = None

def initialize_inference_detector():
    """Initialize the global Inference Pipeline detector"""
    global inference_detector
    
    # Your Inference Pipeline credentials
    API_KEY = "YDZxw1AQEvclkzV0ZLOz"
    WORKSPACE_NAME = "hockey-fghn7"
    WORKFLOW_ID = "custom-workflow-3"
    
    inference_detector = InferencePlayerDetector(API_KEY, WORKSPACE_NAME, WORKFLOW_ID)
    return inference_detector

def get_inference_detector():
    """Get the global Inference Pipeline detector instance"""
    global inference_detector
    if inference_detector is None:
        initialize_inference_detector()
    return inference_detector
