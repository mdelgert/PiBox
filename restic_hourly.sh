#!/bin/bash

# Define the source folder and backup folder
SOURCE_FOLDER="/mnt/d1/"
BACKUP_FOLDER="/mnt/d2/restic_hourly"

# Define the password (replace 'test' with your actual password)
#export RESTIC_PASSWORD=repo-password
export RESTIC_PASSWORD_FILE=/home/mdelgert/.resticpwd

# Perform the backup
restic -r "$BACKUP_FOLDER" backup "$SOURCE_FOLDER"

# Print backup summary
restic -r "$BACKUP_FOLDER" snapshots