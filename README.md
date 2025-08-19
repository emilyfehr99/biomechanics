# 🎬 Biomechanical Dashboard

A powerful, private biomechanical analysis tool for hockey video analysis. Generate skeleton animations, track player movements, and analyze skating biomechanics using simple 2D skeleton generation.

## 🚀 **Quick Start**

### **Option 1: One-Click Startup (Recommended)**
```bash
# On Mac/Linux
./start_dashboard.sh

# On Windows
start_dashboard.bat
```

### **Option 2: Manual Startup**
```bash
python3 app.py
```

Then open your browser to: **http://localhost:8080**

## 📱 **What You Can Do**

- **🎬 Skeleton Analysis**: Track player pose and generate skeleton animations
  
- **⚡ Player Speed**: Track player speed and acceleration with enhanced ByteTracker
- **📊 Data Export**: Download CSV data and annotated videos for further analysis

## 🔒 **Private & Secure**

- **Local Only**: Runs completely on your machine
- **No Internet**: Works offline with no data sharing
- **No Accounts**: No login required, just start and use
- **Private Data**: All videos and analysis stay on your computer

## 📁 **Project Structure**

```
biomechanical_dashboard/
├── app.py                 # Main Flask application
├── start_dashboard.sh     # Mac/Linux startup script
├── start_dashboard.bat    # Windows startup script
├── HOSTING_GUIDE.md      # Detailed hosting instructions
├── templates/             # HTML templates
├── uploads/              # Video upload directory
├── outputs/              # Analysis results
└── requirements.txt      # Python dependencies
```

## 🛠️ **Technical Features**

- **TRUE STREAMING**: Processes entire videos in real-time
- **Simple 2D Skeleton**: Fast, efficient skeleton generation
- **MediaPipe Integration**: Professional pose detection
- **YOLOv8 + ByteTracker**: Enhanced player tracking
- **Hardware Acceleration**: H.264 encoding when available

## 📖 **Documentation**

- **[HOSTING_GUIDE.md](HOSTING_GUIDE.md)** - How to run and host privately
- **[QUICK_START.md](QUICK_START.md)** - Quick setup instructions
- **[SUMMARY.md](SUMMARY.md)** - Project overview and features

## 🎯 **Perfect For**

- **Hockey Coaches**: Analyze player technique and form
- **Sports Scientists**: Biomechanical research and data collection
- **Players**: Review and improve skating mechanics
- **Researchers**: Motion analysis and performance studies

## 🚨 **Requirements**

- Python 3.7+
- OpenCV
- MediaPipe
- Flask
- NumPy
- Pandas
- Ultralytics (YOLOv8)

## 💡 **Pro Tips**

1. **Bookmark**: Save `http://localhost:8080` in your browser
2. **Quick Access**: Use the startup scripts for one-click launching
3. **Background**: Run in a separate terminal tab while you work
4. **Mobile**: Access from your phone on the same WiFi (optional)

---

**🎉 Ready to analyze some hockey videos?** Just run the startup script and you'll have your own private biomechanical analysis tool running locally!
