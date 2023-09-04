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