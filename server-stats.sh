#!/bin/bash

echo "===== SERVER PERFORMANCE STATS ====="
echo

# CPU Usage
echo ">>> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}'
echo

# Memory Usage
echo ">>> Memory Usage:"
free -m | awk 'NR==2 {
    total=$2;
    used=$3;
    free=$4;
    percent=(used/total)*100;
    printf "Total: %sMB\nUsed: %sMB\nFree: %sMB\nUsage: %.2f%%\n", total, used, free, percent
}'
echo

# Disk Usage
echo ">>> Disk Usage:"
df -h / | awk 'NR==2 {
    total=$2;
    used=$3;
    free=$4;
    percent=$5;
    printf "Total: %s\nUsed: %s\nFree: %s\nUsage: %s\n", total, used, free, percent
}'
echo

# Top 5 Processes by CPU Usage
echo ">>> Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory Usage
echo ">>> Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo

echo "===== END OF REPORT ====="
