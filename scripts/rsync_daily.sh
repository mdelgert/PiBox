#!/bin/bash

# Source and destination directories
source_dir="/mnt/d1/"
destination_dir="/mnt/d2/rsync/daily"

# Run rsync with options, including --delete
sudo rsync -avz --delete --exclude '/docker' "$source_dir" "$destination_dir"

# Example Crontab Daily at 12:00 AM
#0 0 * * * /home/mdelgert/scripts/rsync_daily.sh