#!/usr/bin/env python3
"""
Test script for the biomechanical dashboard
"""

import requests
import time
import sys

def test_app():
    """Test if the Flask app is running and responding"""
    try:
        # Test the main page
        response = requests.get('http://localhost:8080', timeout=5)
        if response.status_code == 200:
            print("✅ Flask app is running successfully!")
            print(f"📄 Response length: {len(response.text)} characters")
            return True
        else:
            print(f"❌ Flask app returned status code: {response.status_code}")
            return False
    except requests.exceptions.ConnectionError:
        print("❌ Could not connect to Flask app at http://localhost:8080")
        print("   Make sure the app is running with: python3 run.py")
        return False
    except Exception as e:
        print(f"❌ Error testing Flask app: {e}")
        return False

if __name__ == "__main__":
    print("🧪 Testing Biomechanical Dashboard...")
    print("=" * 40)
    
    success = test_app()
    
    if success:
        print("\n🎉 Dashboard is ready to use!")
        print("🌐 Open your browser to: http://localhost:8080")
    else:
        print("\n⚠️  Dashboard test failed")
        print("   Check the console output for error messages")
        sys.exit(1)

