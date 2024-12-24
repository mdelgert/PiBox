# Setup samba

```bash
sudo apt update
sudo apt install samba wsdd
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
#clear everything use example smb.conf
sudo truncate -s 0 /etc/samba/smb.conf 
#see smb.conf as example
sudo nano /etc/samba/smb.conf 
sudo smbpasswd -a mdelgert
#or systemctl restart smb
sudo systemctl start smbd 
sudo systemctl enable smbd
#enable windows clients network browser in GUI
sudo systemctl start wsdd 
sudo systemctl enable wsdd
sudo wsdd --version
sudo samba --version
#to see status
sudo smbstatus 
```