#!/bin/bash

# Source directory to be backed up
source_dir="/mnt/ssd1"

# Backup destination directory
backup_dir="/mnt/ssd2"

# Date and time for backup folder (e.g., YYYYMMDD_HHMMSS)
timestamp=$(date +"%Y%m%d_%H%M%S")

# Create a backup folder with the current timestamp
backup_folder="$backup_dir/backup_$timestamp"

# rsync options:
# -a: Archive mode (recursively copy files and preserve attributes)
# -v: Verbose output (optional)
# --delete: Delete files in the backup that no longer exist in the source
rsync -av --delete "$source_dir" "$backup_folder"

# Check if the rsync command was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed with error code $?."
fi