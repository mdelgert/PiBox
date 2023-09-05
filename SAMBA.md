### Samba Setup
sudo apt install samba samba-common-bin
sudo cp -p /etc/samba/smb.conf /etc/samba/smb.conf.original
sudo chmod -R 777 /mnt/ssd1
sudo chmod -R 777 /mnt/ssd2

# add the user
sudo smbpasswd -a user

# restart the service
sudo systemctl restart smbd

sudo nano /etc/samba/smb.conf

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

### How to prevent Samba-server from auto-providing users /home-directory as a shared-folder?
https://unix.stackexchange.com/questions/418195/samba-how-to-prevent-samba-server-from-auto-providing-users-home-directory-as

[homes]
comment = Home Directories
available = no <---- add this line
browseable = yes
writable = yes
valid users = %S
valid users = MYDOMAIN\%S