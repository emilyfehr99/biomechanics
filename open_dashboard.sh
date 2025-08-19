#!/bin/bash

# 🌐 Open Biomechanical Dashboard in Browser
# This script opens your dashboard in your preferred browser

echo "🌐 Opening Biomechanical Dashboard..."

# Check if dashboard is running
if [ ! -f "dashboard.pid" ]; then
    echo "❌ Dashboard is not running. Starting it first..."
    ./auto_start.sh
fi

# Determine port
PORT=${PORT:-8888}

# Check if dashboard is accessible
if ! curl -s http://localhost:${PORT} > /dev/null; then
    echo "❌ Dashboard is not responding. Starting it..."
    PORT=${PORT} ./auto_start.sh
    sleep 5
fi

echo "✅ Dashboard is running and accessible!"
echo "🌐 Opening in browser..."

# Try to open in preferred browser order (Safari first)
if [ -d "/Applications/Safari.app" ]; then
    echo "🍎 Opening in Safari..."
    open -a Safari http://localhost:${PORT}
elif [ -d "/Applications/Google Chrome.app" ]; then
    echo "📱 Opening in Google Chrome..."
    open -a "Google Chrome" http://localhost:${PORT}
elif [ -d "/Applications/Firefox.app" ]; then
    echo "🦊 Opening in Firefox..."
    open -a Firefox http://localhost:${PORT}
else
    echo "🌐 Opening in default browser..."
    open http://localhost:${PORT}
fi

echo ""
echo "🎉 Dashboard opened in browser!"
echo "🌐 URL: http://localhost:${PORT}"
echo ""
echo "💡 The dashboard will keep running even if you close the browser"
echo "💡 To stop the dashboard: ./manage_dashboard.sh stop"
