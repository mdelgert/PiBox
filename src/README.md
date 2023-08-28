# Setup
sudo apt install python3 python3-pip python3-venv
python3 -m pip install --user virtualenv
python3 -m venv env
source env/bin/activate
pip install requests
pip3 freeze > requirements.txt
pip install pyinstaller

# Packager
pyinstaller -F test.py