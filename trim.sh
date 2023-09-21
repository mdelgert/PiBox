#!/bin/bash

#logs dir
logs_dir="/mnt/ssd1/scripts/logs_trim"

# Define the timestamp format
timestamp=$(date +"%Y%m%d_%H%M%S")

# Set the log file name with the timestamp
log_file="$timestamp.log"

# Execute your script and redirect both stdout and stderr to the log file
sudo mkdir $logs_dir
sudo fstrim -v /mnt/ssd1 &> $logs_dir + "/ssd1_$log_file"
sudo fstrim -v /mnt/ssd2 &> $logs_dir + "/ssd2_$log_file"

# Optionally, you can also display the log file path to the terminal
echo "Output has been logged to: $log_file"