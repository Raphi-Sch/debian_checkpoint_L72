#!/bin/sh

sudo chroot ../debian12-armhf /usr/bin/qemu-arm-static /bin/bash -c "

# Use sysvinit instead of systemd
apt install -y sysvinit-core busybox

update-rc.d networking disable 2> /dev/null
update-rc.d dhcpd disable 2> /dev/null
update-rc.d dhclient disable 2> /dev/null
update-rc.d udev disable 2> /dev/null
update-rc.d systemd-udevd disable 2> /dev/null
update-rc.d rsyslog disable 2> /dev/null

rm -f /etc/rc*.d/*udev*
rm -f /etc/rc*.d/*systemd*
rm -f /etc/rc*.d/*dbus*

# Set root password
echo \"Set new root password for device\"
passwd root

# Hostname
echo "checkpoint" > /etc/hostname

# Hosts file
cat > /etc/hosts << 'EOF'
127.0.0.1   localhost
127.0.1.1   checkpoint
EOF

# fstab
cat > /etc/fstab << 'EOF'
/dev/sda2   /      ext3  errors=remount-ro  0 1
/dev/sda1   /boot  ext3  defaults           0 2
tmpfs       /tmp   tmpfs defaults,size=256M 0 0
EOF

# Serial console for kernel 3.10 / old systemd
mkdir -p /etc/systemd/system/getty.target.wants
ln -sf /lib/systemd/system/serial-getty@.service \
  /etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service

# Disable unused gettys (only serial matters here)
systemctl disable getty@tty1 2>/dev/null || true

# Enable TTY over Serial
cat > /etc/fstab << 'EOF'

EOF

# Basic network config via /etc/network/interfaces
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# SSH: permit root login for remote access
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime

# Exit chroot
exit

"
