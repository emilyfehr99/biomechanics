#!/usr/bin/env python3
"""
Hockey Biomechanics Analysis Dashboard
Run this file to start the dashboard server
"""

import os
import sys
import webbrowser
from pathlib import Path
import argparse

# Add the current directory to Python path
current_dir = Path(__file__).parent
sys.path.insert(0, str(current_dir))

# Import and run the Flask app
from app import app

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=int(os.environ.get('PORT', 8080)))
    args = parser.parse_args()
    port = args.port

    print("🏒 Hockey Biomechanics Analysis Dashboard")
    print("=" * 50)
    print(f"📁 Working directory: {current_dir}")
    print(f"🌐 Starting server on: http://localhost:{port}")
    print(f"⏹️  Press Ctrl+C to stop the server")
    print("=" * 50)
    
    # Try to open browser automatically
    try:
        webbrowser.open(f'http://localhost:{port}')
        print("🌐 Browser opened automatically")
    except:
        print("⚠️  Could not open browser automatically")
        print(f"   Please open http://localhost:{port} in your browser")
    
    print("=" * 50)
    
    # Start the Flask app
    try:
        app.run(debug=False, host='0.0.0.0', port=port)
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")

if __name__ == "__main__":
    main()
