#!/bin/sh

./mount_disk.sh

# Copy rootfs to sdb2
echo "Copying 'debian12-armhf/' to '/mnt/cpdebian'..."
sudo cp -a ../debian12-armhf/. /mnt/cpdebian/

# Remove QEMU binary from the target
sudo rm /mnt/cpdebian/usr/bin/qemu-arm-static

sync

# Verify size
df -h /mnt/cpdebian

./umount_disk.sh