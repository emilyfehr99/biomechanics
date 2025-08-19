#!/bin/bash

# 🎬 Biomechanical Dashboard Management Script
# This script helps you manage your 24/7 running dashboard

DASHBOARD_DIR="/Users/emilyfehr8/CascadeProjects/biomechanical_dashboard"
LOG_FILE="$DASHBOARD_DIR/dashboard.log"
PID_FILE="$DASHBOARD_DIR/dashboard.pid"

case "$1" in
    start)
        echo "🚀 Starting Biomechanical Dashboard..."
        cd "$DASHBOARD_DIR"
        # Prefer port from env, default to 8888
        PORT=${PORT:-8888} nohup python3 app.py > dashboard.log 2>&1 &
        echo $! > dashboard.pid
        echo "✅ Dashboard started! PID: $(cat dashboard.pid)"
        echo "🌐 Access at: http://localhost:${PORT:-8888}"
        echo "📝 Logs: $LOG_FILE"
        ;;
    stop)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            echo "🛑 Stopping Dashboard (PID: $PID)..."
            kill "$PID" 2>/dev/null
            rm -f "$PID_FILE"
            echo "✅ Dashboard stopped"
        else
            echo "❌ No PID file found. Dashboard may not be running."
        fi
        ;;
    restart)
        echo "🔄 Restarting Dashboard..."
        $0 stop
        sleep 2
        $0 start
        ;;
    status)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p "$PID" > /dev/null 2>&1; then
                echo "✅ Dashboard is RUNNING (PID: $PID)"
                echo "🌐 Access at: http://localhost:${PORT:-8888}"
                echo "📝 Logs: $LOG_FILE"
            else
                echo "❌ Dashboard PID exists but process is not running"
                rm -f "$PID_FILE"
            fi
        else
            echo "❌ Dashboard is NOT RUNNING"
        fi
        ;;
    logs)
        if [ -f "$LOG_FILE" ]; then
            echo "📝 Dashboard Logs (last 20 lines):"
            echo "=================================="
            tail -20 "$LOG_FILE"
        else
            echo "❌ No log file found"
        fi
        ;;
    *)
        echo "🎬 Biomechanical Dashboard Management"
        echo "=================================="
        echo "Usage: $0 {start|stop|restart|status|logs}"
        echo ""
        echo "Commands:"
        echo "  start   - Start the dashboard in background"
        echo "  stop    - Stop the running dashboard"
        echo "  restart - Restart the dashboard"
        echo "  status  - Check if dashboard is running"
        echo "  logs    - Show recent log entries"
        echo ""
        echo "🌐 Access: http://localhost:8080"
        echo "📁 Location: $DASHBOARD_DIR"
        ;;
esac
