#!/bin/bash

# Source and destination directories
source_dir="/mnt/d1/"
destination_dir="/mnt/d2/rsync/daily"

# Run rsync with options, including --delete
sudo rsync -avz --delete --exclude '/docker' "$source_dir" "$destination_dir"