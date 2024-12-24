Docker to store its files (such as images, containers, and volumes) on a custom directory like `/mnt/d1`. By default, Docker stores these files in `/var/lib/docker`, but you can change this location by modifying Docker's configuration file.

### Steps to Install Docker and Use `/mnt/d1` for Storage:

1. **Install Docker**  
   Install Docker as usual:
   ```bash
   curl -fsSL https://get.docker.com | sudo sh
   # Add your user to the Docker group
   sudo usermod -aG docker $USER
   ```

2. **Stop Docker Service**  
   Before changing the storage location, stop the Docker service:
   ```bash
   sudo systemctl stop docker
   ```

3. **Move Existing Docker Files (Optional)**  
   If Docker has already created files in `/var/lib/docker`, move them to `/mnt/d1`:
   ```bash
   sudo mv /var/lib/docker /mnt/d1/docker
   ```

   If `/mnt/d1/docker` doesn't exist, create it:
   ```bash
   sudo mkdir -p /mnt/d1/docker
   ```

4. **Configure Docker to Use `/mnt/d1/docker`**  
   Update the Docker configuration to point to the new location:
   - Edit or create the file `/etc/docker/daemon.json`:
     ```bash
     sudo nano /etc/docker/daemon.json
     ```
   - Add or modify the following content:
     ```json
     {
       "data-root": "/mnt/d1/docker"
     }
     ```

   Save and close the file.

5. **Ensure Correct Permissions**  
   Set appropriate ownership and permissions on `/mnt/d1/docker`:
   ```bash
   sudo chown -R root:docker /mnt/d1/docker
   sudo chmod -R 700 /mnt/d1/docker
   ```

6. **Restart Docker**  
   Start the Docker service again:
   ```bash
   sudo systemctl start docker
   ```

7. **Verify the New Location**  
   Check Docker’s storage location by inspecting the `info` command output:
   ```bash
   docker info | grep "Docker Root Dir"
   ```
   It should show:
   ```
   Docker Root Dir: /mnt/d1/docker
   ```

---

### Notes:
- **Performance**: Ensure `/mnt/d1` has good performance for Docker's I/O needs (e.g., SSD vs. HDD).
- **Storage Space**: Ensure sufficient space is available on `/mnt/d1` for Docker images, containers, and volumes.
- **Backup**: Regularly back up the `/mnt/d1/docker` directory to avoid data loss.
- **Compatibility**: This approach works with all storage backends supported by Docker, including `overlay2` and `aufs`.