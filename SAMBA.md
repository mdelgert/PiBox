### Samba Setup
sudo apt install samba samba-common-bin
sudo cp -p /etc/samba/smb.conf /etc/samba/smb.conf.original
sudo chmod -R 777 /mnt/ssd1
sudo chmod -R 777 /mnt/ssd2

[ssd1]
path = /mnt/ssd1
writeable = yes
browseable = yes
create mask = 0777
directory mask = 0777
public = no

[ssd2]
path = /mnt/ssd2
writeable = yes
browseable = yes
create mask = 0777
directory mask = 0777
public = no