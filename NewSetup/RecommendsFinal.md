Here’s a detailed assessment of the manufacturer’s recommendations in the context of your setup with 2TB SSDs and a 4GB eMMC. I'll clarify what is relevant for you and suggest what to implement or modify:

---

### **1. Store System Logs in Memory**
```bash
sudo sed -i "s/#Storage.*/Storage=volatile/" /etc/systemd/journald.conf
sudo sed -i 's/.MaxLevelStore.*/MaxLevelStore=info/' /etc/systemd/journald.conf
sudo sed -i 's/.MaxLevelSyslog.*/MaxLevelSyslog=info/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald.service
```

#### **Effect**
- **`Storage=volatile`**: Stores logs in RAM, preventing writes to the eMMC.
- **`MaxLevelStore=info` and `MaxLevelSyslog=info`**: Reduces log verbosity to minimize RAM usage.

#### **Considerations**
- Logs will **not persist after reboot**, which is fine if you don’t need them for debugging over time.
- If persistent logs are needed, redirect logs to an SSD instead.

#### **Recommendation**
- **Implement if persistent logs are unnecessary**. If you need logs, store them on `/mnt/d1` instead:
  ```bash
  sudo mkdir /mnt/d1/logs
  sudo ln -sf /mnt/d1/logs /var/log
  ```

---

### **2. Disable Swapfile**
```bash
swapoff -a
dphys-swapfile swapoff
```

#### **Effect**
- Disables swap entirely, avoiding writes to the eMMC.
- Can cause issues if the system runs out of memory, especially for memory-intensive workloads like Docker.

#### **Considerations**
- With 2TB SSDs, you can safely create a swap file on an SSD instead of disabling swap entirely.
- Disabling swap is not necessary if the SSD is used.

#### **Recommendation**
- **Do not disable swap.** Instead, create a swap file on `/mnt/d1` (recommended size: 2GB to 4GB):
  ```bash
  sudo fallocate -l 2G /mnt/d1/swapfile
  sudo chmod 600 /mnt/d1/swapfile
  sudo mkswap /mnt/d1/swapfile
  sudo swapon /mnt/d1/swapfile
  ```
  Add to `/etc/fstab`:
  ```bash
  /mnt/d1/swapfile none swap sw,pri=0,nofail 0 0
  ```

---

### **3. Mount `/var/tmp` as `tmpfs`**
```bash
echo "tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=1M 0 0" | sudo tee -a /etc/fstab
```

#### **Effect**
- Mounts `/var/tmp` in RAM, preventing writes to the eMMC.
- **`size=1M`**: Limits `/var/tmp` to 1MB, which might be insufficient for some applications (e.g., Docker, Samba).

#### **Considerations**
- A `1M` limit is too small for most use cases. Increase the size to `100M` or higher if needed.
- If you don’t have high RAM usage, this is beneficial for eMMC longevity.

#### **Recommendation**
- **Implement with increased size**, e.g., 100M:
  ```bash
  echo "tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=100M 0 0" | sudo tee -a /etc/fstab
  ```

---

### **4. Additional Enhancements for Your Setup**

Given your setup, here are additional optimizations:

#### **Relocate Docker Storage to SSD**
Move Docker’s storage directory from the eMMC to `/mnt/d1`:
```bash
sudo mkdir -p /mnt/d1/docker
sudo rsync -a /var/lib/docker/ /mnt/d1/docker/
echo '{"data-root":"/mnt/d1/docker"}' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
```

#### **Redirect Logs to SSD**
If you need persistent logs, redirect `/var/log` to `/mnt/d1`:
```bash
sudo mkdir /mnt/d1/logs
sudo rsync -a /var/log/ /mnt/d1/logs/
sudo ln -sf /mnt/d1/logs /var/log
```

---

### **Updated `/etc/fstab` with All Recommended Changes**
Here’s the final `/etc/fstab` for your setup:
```bash
proc            /proc           proc    defaults          0       0
PARTUUID=06cddfcd-01  /boot/firmware  vfat    defaults          0       2
PARTUUID=06cddfcd-02  /               ext4    defaults,noatime  0       1
UUID=7dadb049-3b3d-4fcf-ac0c-de1f60f90542 /mnt/d1 ext4 defaults,noatime,nofail 0 2
UUID=aed28b67-eb8b-4a09-9e42-dedc2b64e2c6 /mnt/d2 ext4 defaults,noatime,nofail 0 2

# Swap file on SSD /mnt/d1
/mnt/d1/swapfile none swap sw,pri=0,nofail 0 0

# Temporary files in RAM
tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=100M 0 0

# Optional: Logs in RAM (adjust size as needed)
tmpfs /var/log tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=50M 0 0
```

---

### **Summary**

**What to Implement:**
1. **Store Logs in Memory**: Use `Storage=volatile` in `journald.conf` or redirect logs to `/mnt/d1`.
2. **Keep Swap Enabled**: Create a swap file on `/mnt/d1` instead of disabling swap.
3. **Use tmpfs for `/var/tmp`**: Set a reasonable size (e.g., `100M`) for temporary files.
4. **Relocate Docker**: Move Docker storage to `/mnt/d1` to reduce eMMC wear.

These changes ensure optimal performance, durability, and reliability for your setup with minimal wear on the eMMC.