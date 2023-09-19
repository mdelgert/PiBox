### Docker DHCP loses ip at random issue

This is an issue with DHCPCD & Docker on Raspberry, as you already found by yourself. The full discussion is here: Raspberry Pi 4: DHCPCD route socket overflowed. Basically, dhcpcd can be flooded when renewing IP addresses if too many interfaces are present. This is the case when Docker is installed and many containers/networks/services are running. In addition, docker take care of IP addresses and routing on its virtual network, so DHCPCD doesn't need to handle them.

The solution is to configure dhcpcd to ignore all interfaces whose name start with veth (Docker virtual interfaces).

Edit /etc/dhcpcd.conf and append the following line to the end

denyinterfaces veth*

Then restart the service:

sudo systemctl restart dhcpcd.service

Reference: 
https://raspberrypi.stackexchange.com/questions/136320/raspberry-pi-loses-ipv4-address-randomly-but-keeps-ipv6-address
https://github.com/raspberrypi/linux/issues/4092#issuecomment-774512217
https://github.com/raspberrypi/linux/issues/4092
