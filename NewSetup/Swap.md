Adding the swap file to `/etc/fstab` is one step to make it persistent across reboots, but you'll need to ensure the swap file is properly set up before it can be used. Here’s what you should do on Debian 12 (Bookworm) to ensure it works:

### Steps to Use the Swap File:

1. **Create the Swap File (if not already created):**
   ```bash
   sudo fallocate -l 8G /mnt/d1/swapfile
   ```
   Replace `1G` with the desired size of the swap file.

   If `fallocate` isn't supported on your filesystem, you can use:
   ```bash
   sudo dd if=/dev/zero of=/mnt/d1/swapfile bs=1M count=1024
   ```

2. **Set the Correct Permissions:**
   Ensure the file is accessible only by root:
   ```bash
   sudo chmod 600 /mnt/d1/swapfile
   ```

3. **Format the File as Swap:**
   ```bash
   sudo mkswap /mnt/d1/swapfile
   ```

4. **Enable the Swap File:**
   ```bash
   sudo swapon /mnt/d1/swapfile
   ```

5. **Verify Swap Is Active:**
   Check if the swap file is active:
   ```bash
   sudo swapon --show
   ```
   Or:
   ```bash
   free -h
   ```

6. **Add to `/etc/fstab`:**
   ```
   sudo nano /etc/fstab
   /mnt/d1/swapfile none swap sw,pri=0,nofail 0 0
   ```
   Double-check it to ensure it's correct.

7. **Test the Configuration:**
   Test if the swap file is activated correctly on boot by remounting all filesystems:
   ```bash
   sudo mount -a
   ```
   Then reboot the system and confirm the swap file is active:
   ```bash
   sudo swapon --show
   ```

### Notes:
- The `nofail` option ensures the system boots even if the swap file is unavailable (e.g., missing directory or file).
- If the swap file is located on a slower disk, adjust the `pri` value (lower values mean lower priority compared to other swap areas).

If all steps are followed correctly, your swap file should be active and persistent across reboots.

The size of the swap file is not directly tied to the size of your hard drive but rather depends on your system's RAM, workload, and specific requirements. Here’s a guideline to help you decide:

---

### General Swap Size Recommendations:
1. **If You Use Hibernation:**
   - Your swap size should be at least **equal to the amount of RAM** to support hibernation.
   - For example:
     - **8 GB RAM → 8 GB swap**
     - **16 GB RAM → 16 GB swap**

2. **If You Don't Use Hibernation:**
   - The swap size depends on your workload and RAM:
     - **Minimal usage / lots of RAM (16 GB+):** 2–4 GB
     - **Moderate usage / standard workloads:** Match RAM (e.g., 8 GB RAM → 8 GB swap)
     - **Heavy usage (e.g., video editing, virtual machines):** 1.5x–2x RAM

3. **For Servers or Low RAM Systems:**
   - **Low RAM (4 GB or less):** 2x RAM (e.g., 4 GB RAM → 8 GB swap)
   - **Mid-range RAM (8–16 GB):** Equal to RAM or 1.5x RAM

---

### Swap Usage Considerations:
- **More RAM Means Less Swap Is Needed:**
  - If you have 16 GB+ of RAM and don't hibernate, you may rarely need more than 2–4 GB of swap.

- **Workload-Specific Tuning:**
  - High-performance computing, databases, and VMs might need larger swap sizes.
  - Lightweight desktop environments (e.g., XFCE, LXQt) can often use smaller swap.

- **Kernel `swappiness`:**
  - The Linux kernel decides when to use swap based on the `swappiness` setting (default is 60).
  - Lower `swappiness` (e.g., 10) makes the kernel use swap less frequently, good for systems with plenty of RAM.

---

### Example Scenarios:
1. **8 GB RAM, Standard Use:**
   - 8 GB swap (especially if using hibernation).

2. **16 GB RAM, No Hibernation:**
   - 4 GB swap (likely sufficient).

3. **4 GB RAM, Lightweight Desktop:**
   - 8 GB swap (to ensure stability under memory pressure).

4. **16+ GB RAM, Heavy Workloads:**
   - 16–32 GB swap (depending on workload).

---

### Practical Advice:
- For a system with a 2 TB HDD, disk space isn't a constraint, so err on the side of slightly more swap.
- If unsure, use **equal to your RAM** (or slightly more if you hibernate).
- Monitor swap usage with:
  ```bash
  free -h
  ```
  If swap usage frequently approaches maximum, consider increasing its size.