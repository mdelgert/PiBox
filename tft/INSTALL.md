# Install
sudo apt-get install fonts-dejavu python3-pil python3-numpy

cd /usr/bin 
sudo wget https://github.com/mdelgert/PiBox/raw/main/tft/pibox
sudo chmod +x pibox

# Enable spi
sudo raspi-config
interface options
spi --> enable

# Release
# sudo nano /etc/rc.local (debian 12 bookworm does not support this by default)
# Run pibox on start
# pibox &df -h

# Debian bookworm new setup
sudo nano /etc/systemd/system/pibox.service (see pibox.service example provided)
sudo systemctl enable pibox.service
sudo systemctl start pibox.service
sudo systemctl stop pibox.service

