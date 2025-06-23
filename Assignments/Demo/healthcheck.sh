#!/bin/bash
# health-check.sh

while true
do
    echo "Checking app status..."
    curl -s http://localhost:8080/health > /dev/null

    curl -s http://localhost:8080/health > /dev/null
    curl -s http://localhost:8080/health > /dev/null

    #sleep 4  # 💤 Reduces CPU usage significantly
    
done
