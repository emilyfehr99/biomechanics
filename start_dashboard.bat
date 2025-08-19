@echo off
echo 🎬 Starting Biomechanical Dashboard...
echo ======================================

REM Check if Python is available
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Python is not installed or not in PATH
    echo Please install Python and try again
    pause
    exit /b 1
)

REM Check if required packages are installed
echo 🔍 Checking required packages...
python -c "import flask, cv2, mediapipe, numpy, pandas, ultralytics" 2>nul
if %errorlevel% neq 0 (
    echo ⚠️  Some required packages are missing. Installing...
    pip install -r requirements.txt
)

REM Start the dashboard
echo 🚀 Starting dashboard on http://localhost:8080
echo    📱 Open this URL in your browser to use the dashboard
echo    🛑 Press Ctrl+C to stop the dashboard
echo.

REM Start the Flask app
python3 app.py

pause
