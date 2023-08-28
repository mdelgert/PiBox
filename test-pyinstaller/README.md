# Setup
sudo apt install python3 python3-pip python3-venv
python3 -m pip install --user virtualenv
python3 -m venv env
source env/bin/activate
pip3 freeze > requirements.txt
pip install -U pyinstaller

# Packager
pyinstaller -F test.py