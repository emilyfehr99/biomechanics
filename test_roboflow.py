#!/usr/bin/env python3
"""Test Roboflow API connection"""

import sys
import os

# Add current directory to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

try:
    print("🔍 Testing Roboflow API connection...")
    
    # Test basic import
    from roboflow import Roboflow
    print("✅ Roboflow import successful")
    
    # Your credentials
    API_KEY = "YDZxw1AQEvclkzV0ZLOz"
    WORKSPACE_NAME = "hockey-fghn7"
    WORKFLOW_ID = "custom-workflow-3"
    
    print(f"🔑 API Key: {API_KEY[:8]}...")
    print(f"🏢 Workspace: {WORKSPACE_NAME}")
    print(f"⚙️  Workflow: {WORKFLOW_ID}")
    
    # Initialize Roboflow
    print("🚀 Initializing Roboflow...")
    rf = Roboflow(api_key=API_KEY)
    print("✅ Roboflow instance created")
    
    # Try to access workspace
    print("🏢 Accessing workspace...")
    workspace = rf.workspace(WORKSPACE_NAME)
    print("✅ Workspace accessed")
    
    # Try to access workflow
    print("⚙️  Accessing workflow...")
    try:
        workflow = workspace.workflow(WORKFLOW_ID)
        print("✅ Workflow accessed successfully")
    except AttributeError as e:
        print(f"⚠️  Workflow attribute error: {e}")
        try:
            # Try project instead
            workflow = workspace.project(WORKFLOW_ID)
            print("✅ Project accessed successfully")
        except AttributeError as e2:
            print(f"⚠️  Project attribute error: {e2}")
            try:
                # Try direct project access
                workflow = rf.project(f"{WORKSPACE_NAME}/{WORKFLOW_ID}")
                print("✅ Direct project access successful")
            except Exception as e3:
                print(f"❌ Direct project access failed: {e3}")
                workflow = None
    
    if workflow:
        print("🎯 Testing prediction...")
        # Test with a simple image URL
        try:
            # Test with a sample image URL
            test_url = "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400"
            result = workflow.predict(test_url, confidence=40, overlap=30)
            print("✅ Prediction successful!")
            print(f"📊 Result type: {type(result)}")
            if hasattr(result, 'json'):
                print("✅ Result has .json() method")
            else:
                print("⚠️  Result doesn't have .json() method")
        except Exception as e:
            print(f"❌ Prediction failed: {e}")
    else:
        print("❌ No workflow/project available")
        
except ImportError as e:
    print(f"❌ Import error: {e}")
except Exception as e:
    print(f"❌ Unexpected error: {e}")
    import traceback
    traceback.print_exc()

print("🏁 Test complete!")
