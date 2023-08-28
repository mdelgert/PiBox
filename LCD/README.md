https://github.com/kubesail/pibox-os
https://learn.adafruit.com/adafruit-mini-pitft-135x240-color-tft-add-on-for-raspberry-pi/python-setup
https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/
https://pyinstaller.org/en/stable/
https://stackoverflow.com/questions/4556424/how-to-make-my-python-script-easy-portable-or-how-to-compile-into-binary-with-a
https://realpython.com/pyinstaller-python/
https://mounirboulwafa.medium.com/creating-a-single-executable-file-exe-from-a-python-program-abda6a41f74f
https://github.com/marketplace/actions/pyinstaller-windows
https://github.com/JackMcKew/pyinstaller-action-windows-example/tree/master/src
https://github.com/marketplace/actions/pyinstaller-linux
https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/
https://www.scaler.com/topics/how-to-create-requirements-txt-python/
https://github.com/marketplace?type=actions&query=PyInstaller+

# Setup
sudo apt install python3 python3-pip python3-venv
python3 -m pip install --user virtualenv
python3 -m venv env
source env/bin/activate
pip3 install adafruit-circuitpython-rgb-display
pip3 install --upgrade --force-reinstall spidev
sudo apt-get install fonts-dejavu python3-pil python3-numpy
pip3 freeze > requirements.txt

# Enable spi
sudo raspi-config
interface options
spi --> enable

# Packager
# pip install -U pyinstaller
pip install pyinstaller
pyinstaller -F pibox.py

# Release
sudo nano /etc/rc.local
sudo python /home/mdelgert/source/PiBox/LCD/example4.py &

