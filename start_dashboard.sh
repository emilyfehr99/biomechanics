#!/bin/bash

echo "🎬 Starting Biomechanical Dashboard..."
echo "======================================"

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "❌ Error: Python 3 is not installed or not in PATH"
    echo "Please install Python 3 and try again"
    exit 1
fi

# Check if required packages are installed
echo "🔍 Checking required packages..."
$PYTHON_CMD -c "import flask, cv2, mediapipe, numpy, pandas, ultralytics" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "⚠️  Some required packages are missing. Installing..."
    pip3 install -r requirements.txt
fi

# Start the dashboard
echo "🚀 Starting dashboard on http://localhost:8080"
echo "   📱 Open this URL in your browser to use the dashboard"
echo "   🛑 Press Ctrl+C to stop the dashboard"
echo ""

# Start the Flask app
python3 app.py
