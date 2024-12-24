You are running kernel version `6.6.62+rpt-rpi-v8`, which is a Raspberry Pi-specific 64-bit kernel. This kernel supports modern features, including cgroup memory and swap accounting. However, the necessary features might not be enabled by default.

Here’s how you can enable memory and swap limit support for Docker on your Raspberry Pi:

---

### **Enable cgroup Memory and Swap Accounting**

1. **Edit GRUB Configuration**  
   Raspberry Pi systems typically don’t use GRUB, so you’ll need to edit the boot configuration file directly:
   ```bash
   sudo nano /boot/firmware/cmdline.txt
   ```
   Add the following parameters to the existing line (do not create a new line):
   ```
   cgroup_enable=memory swapaccount=1
   ```

   Example (the line should remain a single line):
   ```
   console=serial0,115200 console=tty1 root=PARTUUID=abcd1234-02 rootfstype=ext4 fsck.repair=yes cgroup_enable=memory swapaccount=1
   ```

2. **Reboot the System**  
   After saving the file, reboot your Raspberry Pi to apply the changes:
   ```bash
   sudo reboot
   ```

3. **Verify Changes**  
   After rebooting, check if the warnings are resolved:
   ```bash
   docker info | grep "WARNING"
   ```

   If the warnings no longer appear, memory and swap limits are successfully enabled.

---

### **Check cgroup Support**

If the warnings persist, verify that `cgroup` support is active:

1. **Check Mounted cgroup Subsystems:**
   ```bash
   mount | grep cgroup
   ```
   Ensure `memory` and `swap` are listed. If not, you might need to manually enable them.

2. **Enable Required Subsystems:**
   Add the following to `/boot/cmdline.txt`:
   ```
   systemd.unified_cgroup_hierarchy=false cgroup_memory=1
   ```
   Save, reboot, and check again.

---

### **Alternative: Ignore the Warnings**

If you don't need memory or swap limits for Docker containers, these warnings can safely be ignored. Your setup will work fine for most use cases without this feature enabled.