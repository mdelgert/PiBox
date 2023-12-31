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

/root/.pyenv/shims/pyinstaller --clean -y --dist ./dist/linux --workpath /tmp $SPEC_FILE
chown -R --reference=. ./dist/linux

pyinstaller --clean -y --dist ./dist/windows --workpath /tmp $SPEC_FILE
chown -R --reference=. ./dist/windows

# Tag release
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0

# Delete tag
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0