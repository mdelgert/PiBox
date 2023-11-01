#!/bin/bash

# Source and destination directories
source_dir="/mnt/d1/"
destination_dir="/mnt/d2/rsync/monthly"

# Run rsync with options, including --delete
sudo rsync -avz --delete --exclude '/docker' "$source_dir" "$destination_dir"

# Example Crontab Monthly backup at 2:00 AM
#0 2 1 * * /home/mdelgert/scripts/rsync_monthly.sh