# Install
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# Add your user to the Docker group
sudo usermod -aG docker $USER

# Sanity check that both tools were installed successfully
docker --version
docker compose version

# Test
sudo reboot
docker run hello-world

# Specify data directory
https://tienbm90.medium.com/how-to-change-docker-root-data-directory-89a39be1a70b#:~:text=The%20standard%20data%20directory%20used,your%20images%2C%20volumes%2C%20etc.

sudo service docker stop
nano /etc/docker/daemon.json
{ 
   "data-root": "/mnt/ssd1/docker"
}

sudo rsync -aP /var/lib/docker/ "/mnt/ssd1/docker"
sudo cp -rp /var/lib/docker/* "/mnt/ssd1/docker/"
sudo mv /var/lib/docker /var/lib/docker.old
sudo service docker start

### Clean old data.
rm -rf /var/lib/docker.old