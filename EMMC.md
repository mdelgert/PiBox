# Store system logs in memory, instead of writing to disk, and lower log verbosity
sudo sed -i "s/#Storage.*/Storage=volatile/" /etc/systemd/journald.conf
sudo sed -i 's/.MaxLevelStore.*/MaxLevelStore=info/' /etc/systemd/journald.conf
sudo sed -i 's/.MaxLevelSyslog.*/MaxLevelSyslog=info/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald.service

# Disable swapfile - note that while you can use a swapspace on an SSD, Swap and Kubernetes do not play nicely for free.
# So the simplest option is to just disable swap entirely
sudo swapoff -a
sudo dphys-swapfile swapoff

# Mount /var/tmp as tmpfs filesystems to extend EMMC lifetime
echo "tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=1M 0 0" | sudo tee -a /etc/fstab
