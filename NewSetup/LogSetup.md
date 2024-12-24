Here's a complete `README.md` file with detailed instructions for setting up log redirection to an SSD and verifying the setup:

---

# Redirecting Logs to an SSD on a Linux System

This guide provides step-by-step instructions to redirect all system logs from `/var/log` to an SSD mounted at `/mnt/d1`, minimizing writes to the MMC for better longevity and performance.

---

## Prerequisites

1. The SSD must already be mounted at `/mnt/d1`.
   - If not, mount it and add it to `/etc/fstab` for persistence.
2. Root access is required to perform these actions.

---

## Instructions

### Step 1: Move `/var/log` to the SSD

1. **Create a Log Directory on the SSD**  
   ```bash
   sudo mkdir -p /mnt/d1/log
   ```

2. **Move Existing Logs to the SSD**  
   ```bash
   sudo rsync -av /var/log/ /mnt/d1/log/
   ```

3. **Remove the Original `/var/log` Directory**  
   ```bash
   sudo rm -rf /var/log
   ```

4. **Create a Symlink to the SSD**  
   ```bash
   sudo ln -s /mnt/d1/log /var/log
   ```

---

### Step 2: Fine-Tune `systemd-journald`

1. **Edit `systemd-journald` Configuration**  
   Open the configuration file:
   ```bash
   sudo nano /etc/systemd/journald.conf
   ```

   Add or modify the following lines:
   ```
   Storage=persistent
   RuntimeMaxUse=128M
   SystemMaxUse=2G
   SystemKeepFree=512M
   ```

   - **`Storage=persistent`**: Ensures logs are stored on disk.
   - **`RuntimeMaxUse`**: Limits memory-based logs to 128 MB.
   - **`SystemMaxUse`**: Limits total log storage to 2 GB.
   - **`SystemKeepFree`**: Ensures at least 512 MB of free space on the disk.

2. **Restart `systemd-journald`**  
   Apply the changes:
   ```bash
   sudo systemctl restart systemd-journald
   ```

---

### Step 3: Verify the Setup

1. **Write a Test Log Entry**  
   Use the `logger` command to write a test message:
   ```bash
   logger "Test log entry to verify /var/log redirection"
   ```

2. **Search for the Test Log Entry**  
   Check the logs for the test message:
   ```bash
   journalctl | grep "Test log entry to verify /var/log redirection"
   ```

3. **Confirm Logs Are on the SSD**  
   Verify the message is stored on the SSD:
   ```bash
   sudo grep -r "Test log entry to verify /var/log redirection" /mnt/d1/log/
   ```

4. **Monitor Disk Writes**  
   Use `iotop` to ensure no writes are occurring on the MMC (`/dev/mmcblk*`):
   ```bash
   sudo iotop -o
   ```

---

### Step 4: Reboot and Validate Persistence

1. Reboot the system:
   ```bash
   sudo reboot
   ```

2. After rebooting:
   - Confirm `/var/log` is still symlinked to the SSD:
     ```bash
     ls -l /var/log
     ```
   - Verify logs are being written to the SSD:
     ```bash
     sudo journalctl --disk-usage
     ls -l /mnt/d1/log
     ```

---

## Optional: Clean Up Test Logs

After confirming the setup, you can remove the test log entry:
```bash
sudo journalctl --vacuum-size=2G
```

---

## Notes

- **Log Rotation**: Ensure logs do not consume excessive space. Configure log rotation using `logrotate` or systemd settings.
- **MMC Writes**: Avoid unnecessary writes to the MMC by regularly monitoring disk usage with `iotop`.
- **Service-Specific Logs**: Some services (e.g., Samba, Apache) may require their log paths to be updated in their configuration files to ensure they follow the `/var/log` symlink.

---

This setup ensures all logs are redirected to the SSD, protecting the MMC from unnecessary writes while maintaining the standard `/var/log` directory structure for compatibility.

--- 

Feel free to modify this `README.md` to suit your specific requirements!