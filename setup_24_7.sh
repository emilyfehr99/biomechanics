#!/bin/bash

echo "🚀 Setting up 24/7 Biomechanical Dashboard Service..."

# Get the current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLIST_NAME="com.emilyfehr.biomechanical-dashboard.plist"
PLIST_PATH="$SCRIPT_DIR/$PLIST_NAME"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
TARGET_PLIST="$LAUNCH_AGENTS_DIR/$PLIST_NAME"

echo "📁 Current directory: $SCRIPT_DIR"
echo "📋 Plist file: $PLIST_PATH"
echo "🎯 Target location: $TARGET_PLIST"

# Check if plist exists
if [ ! -f "$PLIST_PATH" ]; then
    echo "❌ Error: Plist file not found at $PLIST_PATH"
    exit 1
fi

# Create LaunchAgents directory if it doesn't exist
mkdir -p "$LAUNCH_AGENTS_DIR"

# Copy plist to LaunchAgents
echo "📋 Copying plist to LaunchAgents..."
cp "$PLIST_PATH" "$TARGET_PLIST"

# Load the launch agent
echo "🔄 Loading launch agent..."
launchctl load "$TARGET_PLIST"

# Start the service
echo "▶️  Starting the dashboard service..."
launchctl start com.emilyfehr.biomechanical-dashboard

echo "✅ 24/7 Dashboard Service Setup Complete!"
echo ""
echo "🎯 Your dashboard will now:"
echo "   • Start automatically when you log in"
echo "   • Restart automatically if it crashes"
echo "   • Run continuously in the background"
echo ""
echo "🌐 Access your dashboard at: http://localhost:3425"
echo "📱 Add this URL to Safari favorites for easy access!"
echo ""
echo "📋 To manage the service:"
echo "   • Stop: launchctl stop com.emilyfehr.biomechanical-dashboard"
echo "   • Start: launchctl start com.emilyfehr.biomechanical-dashboard"
echo "   • Unload: launchctl unload $TARGET_PLIST"
echo ""
echo "📊 Check logs at:"
echo "   • Output: $SCRIPT_DIR/dashboard.log"
echo "   • Errors: $SCRIPT_DIR/dashboard_error.log"
