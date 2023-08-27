https://github.com/kubesail/pibox-os
https://learn.adafruit.com/adafruit-mini-pitft-135x240-color-tft-add-on-for-raspberry-pi/python-setup

pip3 install adafruit-circuitpython-rgb-display
pip3 install --upgrade --force-reinstall spidev
sudo apt-get install fonts-dejavu python3-pil python3-numpy

sudo raspi-config
interface options
spi --> enable