# 🎬 Biomechanical Dashboard Management Script (PowerShell)
# This script helps you manage your 24/7 running dashboard

param(
    [Parameter(Position=0)]
    [ValidateSet("start", "stop", "restart", "status", "logs")]
    [string]$Action = "help"
)

$DASHBOARD_DIR = "C:\Users\emilyfehr8\CascadeProjects\biomechanical_dashboard"
$LOG_FILE = "$DASHBOARD_DIR\dashboard.log"
$PID_FILE = "$DASHBOARD_DIR\dashboard.pid"

function Start-Dashboard {
    Write-Host "🚀 Starting Biomechanical Dashboard..." -ForegroundColor Green
    Set-Location $DASHBOARD_DIR
    
    # Start the dashboard in background
    Start-Job -ScriptBlock {
        Set-Location $using:DASHBOARD_DIR
        python3 app.py > dashboard.log 2>&1
    }
    
    # Get the job ID and save it
    $job = Get-Job | Where-Object {$_.State -eq "Running"} | Select-Object -Last 1
    if ($job) {
        $job.Id | Out-File -FilePath $PID_FILE -Encoding ASCII
        Write-Host "✅ Dashboard started! Job ID: $($job.Id)" -ForegroundColor Green
        Write-Host "🌐 Access at: http://localhost:8080" -ForegroundColor Cyan
        Write-Host "📝 Logs: $LOG_FILE" -ForegroundColor Yellow
    } else {
        Write-Host "❌ Failed to start dashboard" -ForegroundColor Red
    }
}

function Stop-Dashboard {
    if (Test-Path $PID_FILE) {
        $jobId = Get-Content $PID_FILE
        Write-Host "🛑 Stopping Dashboard (Job ID: $jobId)..." -ForegroundColor Yellow
        
        try {
            Stop-Job -Id $jobId -ErrorAction SilentlyContinue
            Remove-Job -Id $jobId -ErrorAction SilentlyContinue
            Remove-Item $PID_FILE -ErrorAction SilentlyContinue
            Write-Host "✅ Dashboard stopped" -ForegroundColor Green
        } catch {
            Write-Host "❌ Error stopping dashboard: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ No PID file found. Dashboard may not be running." -ForegroundColor Yellow
    }
}

function Get-DashboardStatus {
    if (Test-Path $PID_FILE) {
        $jobId = Get-Content $PID_FILE
        $job = Get-Job -Id $jobId -ErrorAction SilentlyContinue
        
        if ($job -and $job.State -eq "Running") {
            Write-Host "✅ Dashboard is RUNNING (Job ID: $jobId)" -ForegroundColor Green
            Write-Host "🌐 Access at: http://localhost:8080" -ForegroundColor Cyan
            Write-Host "📝 Logs: $LOG_FILE" -ForegroundColor Yellow
        } else {
            Write-Host "❌ Dashboard Job ID exists but job is not running" -ForegroundColor Red
            Remove-Item $PID_FILE -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "❌ Dashboard is NOT RUNNING" -ForegroundColor Red
    }
}

function Show-DashboardLogs {
    if (Test-Path $LOG_FILE) {
        Write-Host "📝 Dashboard Logs (last 20 lines):" -ForegroundColor Cyan
        Write-Host "==================================" -ForegroundColor Cyan
        Get-Content $LOG_FILE -Tail 20
    } else {
        Write-Host "❌ No log file found" -ForegroundColor Red
    }
}

function Show-Help {
    Write-Host "🎬 Biomechanical Dashboard Management" -ForegroundColor Green
    Write-Host "==================================" -ForegroundColor Green
    Write-Host "Usage: .\manage_dashboard.ps1 {start|stop|restart|status|logs}" -ForegroundColor White
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor White
    Write-Host "  start   - Start the dashboard in background" -ForegroundColor Yellow
    Write-Host "  stop    - Stop the running dashboard" -ForegroundColor Yellow
    Write-Host "  restart - Restart the dashboard" -ForegroundColor Yellow
    Write-Host "  status  - Check if dashboard is running" -ForegroundColor Yellow
    Write-Host "  logs    - Show recent log entries" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🌐 Access: http://localhost:8080" -ForegroundColor Cyan
    Write-Host "📁 Location: $DASHBOARD_DIR" -ForegroundColor Yellow
}

# Main execution
switch ($Action) {
    "start" { Start-Dashboard }
    "stop" { Stop-Dashboard }
    "restart" { 
        Write-Host "🔄 Restarting Dashboard..." -ForegroundColor Yellow
        Stop-Dashboard
        Start-Sleep -Seconds 2
        Start-Dashboard
    }
    "status" { Get-DashboardStatus }
    "logs" { Show-DashboardLogs }
    default { Show-Help }
}
