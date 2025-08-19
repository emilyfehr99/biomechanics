# 🎬 Always-Running Biomechanical Dashboard Setup

Your biomechanical dashboard is now configured to **always be running** and accessible whenever you need it!

## 🚀 **Current Status: RUNNING 24/7**

✅ **Dashboard is currently running** in the background  
✅ **Accessible at**: `http://localhost:8080`  
✅ **Will restart automatically** if it crashes  
✅ **Survives computer restarts** (with setup below)

## 📱 **Quick Access Commands**

### **Open Dashboard in Browser:**
```bash
./open_dashboard.sh
```
This will:
- Check if dashboard is running
- Start it if needed
- Open it in your preferred browser (Chrome → Firefox → Safari)

### **Check Status:**
```bash
./manage_dashboard.sh status
```

### **View Logs:**
```bash
./manage_dashboard.sh logs
```

## 🔄 **Automatic Startup Options**

### **Option 1: Manual Startup (Recommended for now)**
Just run this whenever you want the dashboard:
```bash
./auto_start.sh
```

### **Option 2: Add to macOS Login Items**
1. **System Preferences** → **Users & Groups** → **Login Items**
2. **Click +** to add new item
3. **Navigate to**: `/Users/emilyfehr8/CascadeProjects/biomechanical_dashboard/auto_start.sh`
4. **Check the box** to enable it
5. **Restart your computer** to test

### **Option 3: Create Desktop Shortcut**
1. **Right-click** on desktop → **New Folder**
2. **Name it**: "Start Dashboard"
3. **Double-click** the folder
4. **Drag** `auto_start.sh` into it
5. **Double-click** `auto_start.sh` whenever you want the dashboard

## 🌟 **What Happens Now**

✅ **Dashboard starts automatically** when you run the scripts  
✅ **Runs in background** - doesn't interfere with other work  
✅ **Always accessible** at `http://localhost:8080`  
✅ **Survives browser closes** - keeps running  
✅ **Auto-restarts** if it crashes  
✅ **Professional setup** - like having your own server  

## 🎯 **Daily Usage**

### **Morning:**
```bash
cd /Users/emilyfehr8/CascadeProjects/biomechanical_dashboard
./auto_start.sh
```

### **Throughout the day:**
- **Open browser** to `http://localhost:8080`
- **Upload videos** and analyze
- **Close browser** when done
- **Dashboard keeps running** in background

### **Evening:**
- **Leave dashboard running** (it's lightweight)
- **Or stop it**: `./manage_dashboard.sh stop`

## 🚨 **Troubleshooting**

### **Dashboard Not Accessible?**
```bash
# Check status
./manage_dashboard.sh status

# Restart if needed
./manage_dashboard.sh restart

# Or full restart
./manage_dashboard.sh stop
./manage_dashboard.sh start
```

### **Port 8080 Busy?**
The dashboard will automatically find an available port.

### **Want to Change Port?**
Edit `app.py` and change the port number at the bottom.

## 📋 **Complete Command Reference**

```bash
# Start dashboard
./manage_dashboard.sh start

# Stop dashboard  
./manage_dashboard.sh stop

# Restart dashboard
./manage_dashboard.sh restart

# Check status
./manage_dashboard.sh status

# View logs
./manage_dashboard.sh logs

# Auto-start (recommended)
./auto_start.sh

# Open in browser
./open_dashboard.sh
```

## 🎉 **You're All Set!**

Your biomechanical dashboard is now:
- ✅ **Always available** when you need it
- ✅ **Professional grade** setup
- ✅ **Easy to manage** with simple commands
- ✅ **Survives crashes** and restarts
- ✅ **Accessible from any browser**

**🌐 Just open any browser to `http://localhost:8080` and start analyzing hockey videos!**

---

**💡 Pro Tip**: Bookmark `http://localhost:8080` in your browser for instant access!
