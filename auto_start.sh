#!/bin/bash

# 🎬 Auto-Start Script for Biomechanical Dashboard
# This script will start your dashboard automatically

echo "🚀 Auto-starting Biomechanical Dashboard..."

# Change to dashboard directory
cd "$(dirname "$0")"

# Check if dashboard is already running
if [ -f "dashboard.pid" ]; then
    PID=$(cat dashboard.pid)
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "✅ Dashboard is already running (PID: $PID)"
        echo "🌐 Access at: http://localhost:8080"
        exit 0
    else
        echo "🔄 Removing stale PID file..."
        rm -f dashboard.pid
    fi
fi

# Start the dashboard
echo "🎬 Starting dashboard..."
PORT=${PORT:-8888} ./manage_dashboard.sh start

# Wait a moment for it to start
sleep 3

# Check status
PORT=${PORT:-8888} ./manage_dashboard.sh status

echo ""
echo "🎉 Dashboard auto-started successfully!"
echo "🌐 Access at: http://localhost:${PORT:-8888}"
echo "📱 Open this URL in any browser to use the dashboard"
echo ""
echo "💡 To stop: ./manage_dashboard.sh stop"
echo "💡 To restart: ./manage_dashboard.sh restart"
echo "💡 To check status: ./manage_dashboard.sh status"
