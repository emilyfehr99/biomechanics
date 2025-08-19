# 🎬 Biomechanical Dashboard - Private Hosting Guide

Your biomechanical dashboard is designed to run **privately on your local machine** whenever you want to use it. Here are the different ways to host it:

## 🚀 **Option 1: Simple Startup Scripts (Recommended)**

### **On Mac/Linux:**
```bash
# Make the script executable (first time only)
chmod +x start_dashboard.sh

# Start the dashboard
./start_dashboard.sh
```

### **On Windows:**
```cmd
# Double-click the file or run in Command Prompt
start_dashboard.bat
```

### **On Windows (PowerShell):**
```powershell
# Run PowerShell script
.\start_dashboard.ps1
```

**💡 Note**: All scripts now use `python3` for better compatibility.

## 🖥️ **Option 2: Manual Startup**

### **Step 1: Open Terminal/Command Prompt**
Navigate to your dashboard folder:
```bash
cd /path/to/biomechanical_dashboard
```

### **Step 2: Start the Dashboard**
```bash
# On Mac/Linux
python3 app.py

# On Windows
python3 app.py
```

### **Step 3: Access Your Dashboard**
Open your web browser and go to:
```
http://localhost:8080
```

## 🔧 **What Happens When You Start**

1. **Dashboard Initializes**: Flask server starts on port 8080
2. **Browser Opens**: Automatically opens Safari/Chrome to your dashboard
3. **Ready to Use**: Upload videos and start analyzing!

## 🛑 **How to Stop the Dashboard**

- **Press `Ctrl+C`** in the terminal where it's running
- Or **close the terminal window**

## 🌐 **Access Options**

### **Local Only (Default)**
- **URL**: `http://localhost:8080`
- **Access**: Only from your computer
- **Security**: Completely private

### **Network Access (Optional)**
If you want to access from other devices on your network:
```bash
# Edit app.py line ~2120, change:
app.run(debug=True, host='0.0.0.0', port=8080)

# Then access from other devices using your computer's IP address
http://YOUR_COMPUTER_IP:8080
```

## 📱 **Mobile Access (Optional)**

To access from your phone/tablet on the same WiFi:
1. Find your computer's IP address
2. Start dashboard with network access enabled
3. Access from mobile browser: `http://YOUR_IP:8080`

## 🔒 **Security Features**

- **Local Only**: By default, only accessible from your computer
- **No Internet**: Runs completely offline
- **Private Data**: All videos and analysis stay on your machine
- **No Accounts**: No login required, no data sharing

## 🚨 **Troubleshooting**

### **Port Already in Use**
If you get "port already in use" error:
```bash
# Kill any existing process on port 8080
lsof -ti:8080 | xargs kill -9

# Or change the port in app.py
app.run(debug=True, host='0.0.0.0', port=8081)
```

### **Python Not Found**
Make sure Python 3 is installed and in your PATH:
```bash
python3 --version
```

### **Missing Packages**
Install required packages:
```bash
pip3 install -r requirements.txt
```

## 💡 **Pro Tips**

1. **Bookmark**: Save `http://localhost:8080` in your browser
2. **Quick Start**: Double-click the startup script whenever you need it
3. **Background**: Run in a separate terminal tab while you work
4. **Auto-Start**: Add to your system startup if you use it frequently

## 🎯 **When to Use**

- **Video Analysis**: Upload hockey videos for biomechanical analysis
- **Player Tracking**: Analyze player movements and performance
- **Coaching**: Review technique and form
- **Research**: Collect data for sports science projects
- **Presentations**: Generate analysis videos for coaching sessions

---

**🎉 That's it!** Your dashboard is now ready to run privately whenever you want. Just use the startup scripts and you'll have your own biomechanical analysis tool running locally on your machine.
