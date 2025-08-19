# 🎬 Biomechanical Dashboard - PowerShell Startup Script

Write-Host "🎬 Starting Biomechanical Dashboard..." -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green

# Check if Python is available
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✅ Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Python is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Python and try again" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if required packages are installed
Write-Host "🔍 Checking required packages..." -ForegroundColor Yellow
try {
    python -c "import flask, cv2, mediapipe, numpy, pandas, ultralytics" 2>$null
    Write-Host "✅ All required packages are installed" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Some required packages are missing. Installing..." -ForegroundColor Yellow
    pip install -r requirements.txt
}

# Start the dashboard
Write-Host "🚀 Starting dashboard on http://localhost:8080" -ForegroundColor Cyan
Write-Host "   📱 Open this URL in your browser to use the dashboard" -ForegroundColor White
Write-Host "   🛑 Press Ctrl+C to stop the dashboard" -ForegroundColor White
Write-Host ""

# Start the Flask app
Write-Host "🎬 Starting Flask application..." -ForegroundColor Green
python3 app.py
