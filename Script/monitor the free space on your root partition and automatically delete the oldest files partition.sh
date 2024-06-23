To achieve this on Ubuntu, you can create a script that monitors the free space on the `/` partition and deletes the oldest files from the `joker` folder when the free space falls below 100GB. Here's how you can approach this:

1. **Check Free Space Script**:
   First, create a script that checks the free space on the `/` partition and compares it with a threshold (100GB in your case).

   ```bash
   #!/bin/bash

   THRESHOLD=100000  # 100GB in kilobytes
   PARTITION="/"

   # Get available space on the partition in kilobytes
   available_space=$(df -k --output=avail "$PARTITION" | tail -n 1)

   if [ "$available_space" -lt "$THRESHOLD" ]; then
       echo "Low disk space detected. Deleting oldest files from joker folder..."

       # Enter the joker folder
       cd /path/to/joker

       # Delete the oldest files until free space is at least 100GB
       while [ "$available_space" -lt "$THRESHOLD" ]; do
           # Delete the oldest file (sorted by modification time)
           oldest_file=$(ls -t | tail -n 1)
           rm -f "$oldest_file"

           # Update available space after deletion
           available_space=$(df -k --output=avail "$PARTITION" | tail -n 1)
       done

       echo "Free space is now sufficient."
   else
       echo "Free space is sufficient. No action needed."
   fi
   ```

2. **Explanation**:
   - **THRESHOLD**: Defines the minimum free space threshold in kilobytes. 100GB is represented as 100,000 kilobytes (`100 * 1024 * 1024`).
   - **PARTITION**: Specifies the partition you want to monitor (`/` in this case).
   - The script uses `df` command to get the available space in kilobytes on the specified partition.
   - If the available space is less than the threshold, it changes to the `joker` folder and starts deleting the oldest files until the free space meets or exceeds the threshold.
   - It continuously checks and deletes files in a loop until the condition (`$available_space >= $THRESHOLD`) is satisfied.

3. **Setting Up the Script**:
   - Save the script to a file, for example, `monitor_disk_space.sh`.
   - Make the script executable with `chmod +x monitor_disk_space.sh`.
   - You can then run this script periodically using a cron job to automate the monitoring and cleanup process.

4. **Setting Up Cron Job**:
   - Open your crontab file with `crontab -e`.
   - Add a line to schedule the script to run periodically. For example, to run every hour:

     ```
     0 * * * * /path/to/monitor_disk_space.sh
     ```

   This will run the script `/path/to/monitor_disk_space.sh` every hour (at minute 0 of every hour).

5. **Note**:
   - Replace `/path/to/joker` with the actual path to your `joker` folder.
   - Adjust the `THRESHOLD` value (`100000` kilobytes represents approximately 100GB; adjust if needed).
   - Ensure you understand the implications of deleting files automatically. This script deletes files based on modification time (oldest first).

By following these steps, you can monitor the free space on your `/` partition and automatically delete the oldest files from the `joker` folder when necessary to maintain sufficient free space.
