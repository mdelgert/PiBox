With 2TB SSDs mounted at `/mnt/d1` and `/mnt/d2`, you can optimize your Raspberry Pi's performance and storage longevity. Since you have plenty of space, enabling swap and adjusting your storage strategy can further enhance your setup.

Here are recommendations:

---

### **1. Use SSDs for Swap**
With ample SSD space, enabling a swap file or partition on the SSD is a good idea for memory-intensive workloads. Here's how:

#### **Steps to Create and Enable Swap on SSD:**
1. **Create a Swap File**:
   ```bash
   sudo fallocate -l 2G /mnt/d1/swapfile
   sudo chmod 600 /mnt/d1/swapfile
   sudo mkswap /mnt/d1/swapfile
   ```

2. **Enable Swap**:
   ```bash
   sudo swapon /mnt/d1/swapfile
   ```

3. **Make It Permanent**:
   Add the following line to `/etc/fstab`:
   ```bash
   /mnt/d1/swapfile none swap sw 0 0
   ```

4. **Verify Swap**:
   Check the active swap:
   ```bash
   free -h
   ```

#### **Recommendation**:
- Set the swap size according to your workload. A 2GB swap file is generally sufficient but can be increased if needed.

---

### **2. Redirect Docker Storage to SSD**
Docker uses `/var/lib/docker` by default, which could heavily use your eMMC. Move Docker's storage directory to one of the SSDs to improve performance and reduce wear.

#### **Steps to Move Docker Storage:**
1. **Stop Docker**:
   ```bash
   sudo systemctl stop docker
   ```

2. **Move Docker Data**:
   ```bash
   sudo rsync -a /var/lib/docker/ /mnt/d1/docker/
   ```

3. **Update Docker Configuration**:
   Edit or create `/etc/docker/daemon.json`:
   ```json
   {
     "data-root": "/mnt/d1/docker"
   }
   ```

4. **Restart Docker**:
   ```bash
   sudo systemctl start docker
   ```

#### **Recommendation**:
- Use `/mnt/d1` for Docker data to keep `/mnt/d2` available for Samba or other purposes.

---

### **3. Use SSDs for Samba Shares**
Since SSDs provide fast and reliable storage, hosting your Samba shares on them is ideal. Configure your Samba shares to use `/mnt/d1` or `/mnt/d2`:

#### **Example Samba Configuration**:
Edit `/etc/samba/smb.conf`:
```ini
[d1share]
   path = /mnt/d1
   writeable = yes
   browseable = yes
   guest ok = no
   create mask = 0775
   directory mask = 0775
```
Restart Samba:
```bash
sudo systemctl restart smbd
```

#### **Recommendation**:
- Organize shares by purpose (e.g., Docker data on `/mnt/d1`, general file storage on `/mnt/d2`).

---

### **4. Optimize Mount Options**
To further enhance performance and reduce write cycles:

1. **Enable Noatime**:
   Add `noatime` to the mount options in `/etc/fstab`:
   ```bash
   /dev/sdX1 /mnt/d1 ext4 defaults,noatime 0 2
   /dev/sdX2 /mnt/d2 ext4 defaults,noatime 0 2
   ```

2. **Adjust Scheduler**:
   SSDs benefit from using the `noop` or `mq-deadline` I/O scheduler. To set it:
   ```bash
   echo "mq-deadline" | sudo tee /sys/block/sdX/queue/scheduler
   ```

#### **Recommendation**:
- Use `noatime` and adjust the I/O scheduler for SSD optimization.

---

### **5. Consider Filesystem Options**
For large volumes and many small files, you might want to tune the filesystem for better performance:

- Use `ext4` with optimizations:
  ```bash
  sudo mkfs.ext4 -O ^has_journal /dev/sdX1
  sudo mount -o noatime /dev/sdX1 /mnt/d1
  ```

- Alternatively, consider `xfs` if you expect many large files:
  ```bash
  sudo mkfs.xfs /dev/sdX1
  sudo mount /dev/sdX1 /mnt/d1
  ```

---

### **6. Configure System Logs**
If you want to preserve logs across reboots and minimize eMMC writes, store them on an SSD:

1. **Edit `journald.conf`**:
   ```bash
   sudo sed -i "s/#Storage.*/Storage=persistent/" /etc/systemd/journald.conf
   ```

2. **Create a Log Directory**:
   ```bash
   sudo mkdir /mnt/d1/logs
   sudo ln -sf /mnt/d1/logs /var/log
   ```

3. **Restart the Logging Service**:
   ```bash
   sudo systemctl restart systemd-journald.service
   ```

---

### **7. Backup and Monitor**
Leverage the SSD space for periodic backups of the eMMC or other critical data:
- Use tools like `rsync` or `cron` to create snapshots.
- Set up monitoring tools to ensure health and space usage on SSDs.

---

### **Summary of Actions**
- **Enable Swap**: Create a swap file on `/mnt/d1`.
- **Redirect Docker**: Move Docker data to `/mnt/d1`.
- **Samba Shares**: Use `/mnt/d1` and `/mnt/d2` for shares.
- **Optimize Mount Options**: Use `noatime` and adjust the scheduler.
- **Store Logs**: Redirect logs to an SSD for persistence.
- **Backup**: Utilize space on `/mnt/d2` for snapshots and backups.

These steps will optimize performance, extend the lifespan of your eMMC, and efficiently use your SSDs for Docker, Samba, and other tasks.