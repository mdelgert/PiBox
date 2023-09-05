### SSD1 Setup
lsblk
sudo mkfs.ext4 /dev/sda
sudo mkdir /mnt/ssd1
sudo mount /dev/sda /mnt/ssd1
sudo chown -R $USER:$USER /mnt/ssd1
sudo nano /etc/fstab
/dev/sda   /mnt/ssd1   ext4   defaults   0   2

### SSD2 Setup
lsblk
sudo mkfs.ext4 /dev/sdb
sudo mkdir /mnt/ssd2
sudo mount /dev/sdb /mnt/ssd2
sudo chown -R $USER:$USER /mnt/ssd2
sudo nano /etc/fstab
/dev/sdb   /mnt/ssd2   ext4   defaults   0   2

### Test the mount
sudo umount /mnt/ssd1
sudo umount /mnt/ssd2
sudo mount -a

### Enable trim
https://www.jeffgeerling.com/blog/2020/enabling-trim-on-external-ssd-on-raspberry-pi
sudo fstrim -v /
sudo fstrim -v /mnt/ssd1
sudo fstrim -v /mnt/ssd2



