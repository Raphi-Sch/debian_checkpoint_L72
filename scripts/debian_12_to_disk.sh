#!/bin/sh

./mount_disk.sh

# Copy rootfs to sdb2
echo "Copying 'debian12-armhf/' to '/mnt/cpdebian'..."
sudo rsync -ah --progress ../debian12-armhf/. /mnt/cpdebian/ --exclude 'qemu-arm-static'

sync

# Verify size
df -h /mnt/cpdebian

./umount_disk.sh