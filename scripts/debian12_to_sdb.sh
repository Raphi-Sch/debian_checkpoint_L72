#!/bin/sh

sudo mkdir -p /mnt/cpboot /mnt/cpdebian

# Mount
echo "Mounting '/dev/sdb1' to '/mnt/cpboot'..."
sudo mount /dev/sdb1 /mnt/cpboot
sudo mkdir -p /mnt/cpboot/boot

echo "Mounting '/dev/sdb2' to '/mnt/cpdebian'..."
sudo mount /dev/sdb2 /mnt/cpdebian

# Copy rootfs to sdb2
echo "Copying 'debian12-armhf/' to '/mnt/cpdebian'..."
sudo cp -a ../debian12-armhf/. /mnt/cpdebian/

# Remove QEMU binary from the target
sudo rm /mnt/cpdebian/usr/bin/qemu-arm-static

sync

# Verify size
df -h /mnt/cpdebian

# Unmount
sudo umount /mnt/cpboot /mnt/cpdebian
