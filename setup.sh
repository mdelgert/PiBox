# Mount ssd drives in home
ln -s /mnt/d1 ~/shared

# Setup portainer location
sudo mkdir /mnt/d1/portainer
ln -s /mnt/d1/portainer /portainer

# Setup backup link
sudo mkdir /mnt/d2/backup
sudo ln -s /mnt/d2/backup /mnt/d1/backup
