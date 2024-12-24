Yes, based on the output of `swapon --show`, it indicates that **swap is still active on the `/var/swap` file located on `mmc`**, as well as on the `/mnt/d1/swapfile`.

Here’s what the output means:

- **`/var/swap`:**
  - Type: `file`
  - Size: `512M`
  - Used: `0B` (currently not in use)
  - Priority: `-2` (higher priority than `/mnt/d1/swapfile`)

- **`/mnt/d1/swapfile`:**
  - Type: `file`
  - Size: `8G`
  - Used: `0B` (currently not in use)
  - Priority: `-3` (lower priority, used after `/var/swap` if needed)

---

### To Disable the Swap on `/var/swap`:
If you no longer want to use the swap file on `/var/swap`, follow these steps:

1. **Turn Off Swap for `/var/swap`:**
   ```bash
   sudo swapoff /var/swap
   ```

2. **Verify It Is Disabled:**
   Run the command again to confirm:
   ```bash
   sudo swapon --show
   ```
   `/var/swap` should no longer appear in the list.

3. **Remove `/var/swap` from the System:**
   - If you don’t need it, you can delete the file:
     ```bash
     sudo rm /var/swap
     ```

4. **Update `/etc/fstab`:**
   - Check if `/var/swap` is referenced in `/etc/fstab` and remove or comment out its entry:
     ```bash
     sudo nano /etc/fstab
     ```
     Look for a line referencing `/var/swap` and comment it out by adding `#` at the beginning of the line, or remove it entirely.

5. **Reboot and Verify:**
   After making changes, reboot the system to confirm `/var/swap` is no longer active:
   ```bash
   sudo reboot
   ```
   Then check the active swap:
   ```bash
   sudo swapon --show
   ```

---

### After These Steps:
Only `/mnt/d1/swapfile` should remain active as the swap file on your system.