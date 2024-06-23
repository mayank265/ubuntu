#!/bin/bash

# Check disk usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

# Alert if disk usage is above 90%
if [ ${DISK_USAGE%?} -ge 90 ]; then
    echo "Disk usage is high: $DISK_USAGE"
    # Send alert (e.g., email, Slack message)
fi

# Add checks for CPU, memory, network, etc. as needed
