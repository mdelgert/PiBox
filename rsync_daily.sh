#!/bin/bash

# Source and destination directories
source_dir="/mnt/d1/"
destination_dir="/mnt/d2/rsync_daily"

# Run rsync with options
#sudo rsync -avz "$source_dir" "$destination_dir"

# Run rsync with options, including --delete
sudo rsync -avz --delete "$source_dir" "$destination_dir"