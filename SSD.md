### SSD1 Setup
lsblk
sudo mkfs.ext4 /dev/sda
sudo mkdir /mnt/d1
sudo mount /dev/sda /mnt/d1
sudo chown -R $USER:$USER /mnt/d1
sudo nano /etc/fstab
/dev/sda   /mnt/d1   ext4   defaults   0   2

### SSD2 Setup
lsblk
sudo mkfs.ext4 /dev/sdb
sudo mkdir /mnt/d2
sudo mount /dev/sdb /mnt/d2
sudo chown -R $USER:$USER /mnt/d2
sudo nano /etc/fstab
/dev/sdb   /mnt/d2   ext4   defaults   0   2

### Test the mount
sudo umount /mnt/d1
sudo umount /mnt/d2
sudo mount -a

### Enable trim
https://www.jeffgeerling.com/blog/2020/enabling-trim-on-external-ssd-on-raspberry-pi
sudo fstrim -v /
sudo fstrim -v /mnt/d1
sudo fstrim -v /mnt/d2

