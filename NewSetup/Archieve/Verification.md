To ensure your eMMC is safe and protected from unnecessary wear, here are the **final verification steps** for your setup:

---

### **1. Verify Logging is Redirected to SSD**

Check that logs are not being written to the eMMC by ensuring `/var/log` is redirected to the SSD:

#### **Confirm the Redirection**
```bash
ls -ld /var/log
```
Expected output:
```plaintext
lrwxrwxrwx 1 root root 13 Dec 23 12:00 /var/log -> /mnt/d1/logs
```

#### **Verify Logs Are on SSD**
Ensure logs are being written to `/mnt/d1/logs`:
```bash
sudo ls -l /mnt/d1/logs
```

#### **Test Logging**
Create a test log entry and confirm it appears in the journal:
```bash
logger "Test log entry to confirm SSD logging"
sudo journalctl | grep "Test log entry"
```

---

### **2. Verify Swap is Not on eMMC**

If you are using a swap file on the SSD, confirm it’s configured correctly:

#### **Check Active Swap**
```bash
swapon --show
```
Expected output:
- The `NAME` column should list a file located on `/mnt/d1` (e.g., `/mnt/d1/swapfile`).
- No swap partition or file on the eMMC should appear.

If no swap is configured, that's fine as long as you have enough RAM for your workloads.

---

### **3. Verify Temporary Files Are in RAM**

Temporary files (`/var/tmp`) are often written frequently. If you’ve configured `/var/tmp` as a `tmpfs` (RAM-based filesystem), verify this:

#### **Check `/var/tmp` Mount**
```bash
mount | grep /var/tmp
```
Expected output:
```plaintext
tmpfs on /var/tmp type tmpfs (rw,noatime,nosuid,nodev,noexec,mode=755)
```

If this is not the case, revisit the `/etc/fstab` configuration:
```bash
tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=100M 0 0
```

---

### **4. Verify `noatime` for eMMC Mount**

The `noatime` option reduces writes to the eMMC by disabling file access time updates. Confirm it is applied:

#### **Check `/` Mount Options**
```bash
mount | grep "on / "
```
Expected output:
```plaintext
/dev/mmcblk0p2 on / type ext4 (rw,noatime,...)
```

If `noatime` is missing, update the `/etc/fstab` entry for the eMMC root partition:
```bash
PARTUUID=06cddfcd-02  /  ext4  defaults,noatime  0  1
```

Then remount the filesystem:
```bash
sudo mount -o remount,noatime /
```

---

### **5. Monitor Disk Usage**
Check that the eMMC’s `/` filesystem is not filling up with unexpected writes:

#### **Check Free Space on eMMC**
```bash
df -h /
```
Ensure the usage is consistent with your system setup. Monitor this periodically to detect any unexpected growth.

---

### **6. Check Journald Configuration**
Ensure persistent logging is using the SSD and not the eMMC:

#### **Inspect Journald Configuration**
```bash
sudo cat /etc/systemd/journald.conf | grep "Storage"
```
Expected output:
```plaintext
Storage=persistent
```

If the configuration is correct, verify logs are stored in the SSD’s journal directory:
```bash
ls -l /mnt/d1/logs/journal
```

---

### **7. Optional: Monitor Disk Writes**
Use `iostat` or similar tools to monitor disk activity on the eMMC and SSD:

#### **Install and Use iostat**
```bash
sudo apt install sysstat
iostat -x 1
```

- Look for high `w/s` (writes per second) on the eMMC (`mmcblk0`).
- Most writes should occur on the SSD (`/mnt/d1` or `/mnt/d2`).

---

### **8. Reboot and Test**
Reboot the system to confirm all configurations persist and logs, swap, and temporary files remain redirected to the SSD.

#### **After Reboot**
- Verify logs are still on the SSD (`/mnt/d1/logs`).
- Confirm `noatime` is applied to the eMMC.
- Check active swap (`swapon --show`).

---

### **9. Backup Important Data**
While these configurations protect your eMMC, always keep a backup of critical data in case of unexpected failures.

---

### **Summary Checklist**
1. **Logs**: `/var/log` is redirected to `/mnt/d1/logs`.
2. **Swap**: Swap is on `/mnt/d1`, not the eMMC.
3. **Temporary Files**: `/var/tmp` is a `tmpfs`.
4. **Noatime**: `noatime` is enabled for the eMMC.
5. **Journald**: Logs are stored persistently on the SSD.
6. **Disk Writes**: Minimal write activity on the eMMC.

These steps will ensure your eMMC is protected while maximizing the performance and durability of your Raspberry Pi system.