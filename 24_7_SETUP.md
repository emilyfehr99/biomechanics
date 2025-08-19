# 🎬 24/7 Biomechanical Dashboard Setup

Your dashboard is now configured to run **24/7** so you can access it whenever you want!

## 🚀 **Current Status: RUNNING**

Your dashboard is currently running in the background and accessible at:
**🌐 http://localhost:8080**

## 📱 **How to Use**

1. **Open any web browser** (Safari, Chrome, Firefox, etc.)
2. **Go to**: `http://localhost:8080`
3. **Upload videos** and start analyzing!
4. **Close the browser** when done - the dashboard keeps running

## 🛠️ **Management Commands**

### **On Mac/Linux:**
```bash
# Check status
./manage_dashboard.sh status

# View logs
./manage_dashboard.sh logs

# Restart if needed
./manage_dashboard.sh restart

# Stop completely
./manage_dashboard.sh stop

# Start again
./manage_dashboard.sh start
```

### **On Windows (PowerShell):**
```powershell
# Check status
.\manage_dashboard.ps1 status

# View logs
.\manage_dashboard.ps1 logs

# Restart if needed
.\manage_dashboard.ps1 restart

# Stop completely
.\manage_dashboard.ps1 stop

# Start again
.\manage_dashboard.ps1 start
```

## 🔄 **Automatic Restart**

The dashboard will automatically restart if:
- Your computer restarts
- The process crashes
- You stop it manually

## 📝 **Logs and Monitoring**

- **Log file**: `dashboard.log` (in the dashboard folder)
- **Process ID**: `dashboard.pid` (for management)
- **Real-time logs**: Use the `logs` command above

## 🌟 **Benefits of 24/7 Setup**

✅ **Always Available**: Access anytime without starting manually  
✅ **No Waiting**: Instant access when you need it  
✅ **Persistent**: Survives computer restarts and crashes  
✅ **Background**: Doesn't interfere with other work  
✅ **Professional**: Like having your own private server  

## 🚨 **Troubleshooting**

### **Dashboard Not Accessible?**
```bash
# Check if it's running
./manage_dashboard.sh status

# Restart if needed
./manage_dashboard.sh restart
```

### **Want to Stop It Completely?**
```bash
./manage_dashboard.sh stop
```

### **Need to Update the Code?**
```bash
./manage_dashboard.sh restart
```

## 🎯 **What You Can Do Now**

1. **Open your browser** to `http://localhost:8080`
2. **Upload hockey videos** for analysis
3. **Use all features**:
   - Skeleton tracking
   - Stride analysis  
   - Speed tracking
   - Motion capture
   - Off-ice analysis
4. **Close browser** when done - dashboard keeps running
5. **Come back anytime** - it's always there!

---

**🎉 Congratulations!** You now have your own private biomechanical analysis server running 24/7 on your machine!
