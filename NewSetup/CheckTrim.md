To verify if TRIM is enabled and working on your drives in Debian Bookworm 12, follow these steps:

---

### **1. Check if the Drive Supports TRIM**
Run the following command to check if your SSD supports TRIM:
```bash
lsblk --discard
```
- Look for `DISC-GRAN` and `DISC-MAX` columns in the output.
  - If `DISC-GRAN` has a non-zero value, TRIM is supported.
  - If it is zero, TRIM is not supported by the drive.

---

### **2. Verify fstrim Service Status**
Debian uses the `fstrim` utility to perform TRIM operations periodically. Check if the `fstrim.timer` service is active:
```bash
systemctl status fstrim.timer
```
- If the service is active and enabled, it should run TRIM periodically (usually once a week).
- If it is not active, you can enable it with:
  ```bash
  sudo systemctl enable --now fstrim.timer
  ```

---

### **3. Test TRIM Manually**
You can manually trigger a TRIM operation to test if it works:
```bash
sudo fstrim -v /
```
- Replace `/` with the mount point of the filesystem you want to test (e.g., `/home`).
- If the command outputs the amount of data trimmed, TRIM is working for that filesystem.

---

### **4. Check Filesystem Mount Options**
Verify that the filesystem is mounted with the `discard` option if you want TRIM to be applied automatically on file deletions:
```bash
findmnt -o TARGET,OPTIONS
```
- Look under the `OPTIONS` column for `discard`.
  - If `discard` is not listed, TRIM is not applied automatically.
  - To enable it, add `discard` to the appropriate mount entry in `/etc/fstab` and remount the filesystem:
    ```bash
    sudo mount -o remount,discard /mount/point
    ```

> **Note:** Using the `discard` option can impact performance. Periodic TRIM with `fstrim` is often preferred.

---

### **5. Check Logs for TRIM Operations**
Inspect system logs to confirm if TRIM operations have been performed:
```bash
journalctl -u fstrim
```
- This will show logs from the `fstrim` service.

---

By completing these steps, you can confirm if TRIM is enabled and working correctly on your drives in Debian Bookworm 12.