# Quick Start Guide

## 🚀 Get Started in 3 Steps

### 1. Install Dependencies
```bash
pip install -r requirements.txt
```

### 2. Start the Dashboard
```bash
python run.py
```

### 3. Open Your Browser
- The dashboard will automatically open at `http://localhost:8080`
- Or manually navigate to the URL

## 🎯 What You Can Do

### Upload & Analyze
1. **Upload** your hockey video (MP4, AVI, MOV, MKV)
2. **Select** an analysis type from the 4 available options
3. **Click** "Start Analysis" and wait for processing
4. **Download** your results (videos, CSV data, dashboards)

### Available Analysis Types

| Analysis | Description | Output |
|----------|-------------|---------|
| **Skeleton** | Pose tracking with colored overlay | Annotated video |

| **Goalie** | Goalie movement analysis | Video + CSV |
| **Speed** | Player speed tracking | CSV data |
| **Shot Speed** | ~~Puck velocity measurement~~ *(Removed)* | ~~CSV data~~ |
| **Stick Tracking** | ~~Stick movement analysis~~ *(Removed)* | ~~Annotated video~~ |
| **Player Tracking** | Multi-player detection | Annotated video |

## 📊 Sample Results



### Goalie Analysis
- Glove hand and stick hand velocity
- Leg extension and posture angles
- Center of mass tracking

### Speed Analysis
- Real-time speed tracking
- Conversion to km/h and mph
- Filtered analysis (15-35 km/h range)

## 🔧 Troubleshooting

### If the app doesn't start:
```bash
# Check Python version (needs 3.8+)
python --version

# Install missing dependencies
pip install flask opencv-python numpy pandas mediapipe matplotlib

# Try running directly
python app.py
```

### If analysis fails:
- Use shorter video clips for testing
- Ensure video format is supported (MP4 recommended)
- Check file size (under 500MB)

## 📁 File Locations

- **Uploads**: `uploads/` folder
- **Results**: `outputs/` folder
- **Logs**: Check terminal output

## 🎥 Tips for Best Results

1. **Video Quality**: Use clear, well-lit videos
2. **Resolution**: 720p or 1080p works well
3. **Duration**: 10-30 second clips are ideal
4. **Format**: MP4 with H.264 encoding
5. **Content**: Ensure players are clearly visible

## 🏒 Ready to Analyze!

Your biomechanical analysis dashboard is ready to use. Upload your first hockey video and start getting detailed insights into player performance!
