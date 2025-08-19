#!/bin/bash

# Set the working directory
cd /Users/emilyfehr8/CascadeProjects/biomechanical_dashboard

# Set the PATH to include the correct Python
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Start the dashboard
exec /usr/local/bin/python3 app.py
