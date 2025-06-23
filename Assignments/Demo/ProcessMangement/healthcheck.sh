#!/bin/bash
# health-check.sh

while true
do
    echo "Checking app status..."
    curl -s http://localhost:8080/health > /dev/null

    sleep 5  # 💤 Reduces CPU usage significantly
    
done
