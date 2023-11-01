#!/bin/bash

# Source and destination directories
source_dir="/mnt/d1/"
destination_dir="/mnt/d2/rsync/weekly"

# Run rsync with options, including --delete
sudo rsync -avz --delete --exclude '/docker' "$source_dir" "$destination_dir"

# Example Crontab Weekly at 1:00 AM
#0 1 * * 0 /home/mdelgert/scripts/rsync_weekly.sh