#!/bin/bash

echo "🏒 Hockey Biomechanics Analysis Dashboard Setup"
echo "=============================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Please install pip."
    exit 1
fi

echo "✅ pip3 found: $(pip3 --version)"

# Create virtual environment (optional)
read -p "🤔 Would you like to create a virtual environment? (y/n): " create_venv
if [[ $create_venv == "y" || $create_venv == "Y" ]]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    source venv/bin/activate
    echo "✅ Virtual environment created and activated"
fi

# Install dependencies
echo "📥 Installing Python dependencies..."
pip3 install -r requirements.txt

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies. Please check the error messages above."
    exit 1
fi

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p uploads outputs

# Make run.py executable
chmod +x run.py

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "To start the dashboard:"
echo "  python3 run.py"
echo ""
echo "Or if you created a virtual environment:"
echo "  source venv/bin/activate"
echo "  python run.py"
echo ""
echo "The dashboard will be available at: http://localhost:5000"
echo ""




















