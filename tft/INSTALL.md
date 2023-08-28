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
sudo nano /etc/rc.local

# Run pibox on start
pibox