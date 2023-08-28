source env/bin/activate
pyinstaller -F pibox.py
sudo cp -f dist/pibox /usr/bin