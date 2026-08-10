#!/bin/sh
echo "Compressing initramfs..."
(cd initramfs; find . | cpio -H newc -o | gzip -9 > ../build/initramfs-custom.gz)

echo "Packing initramfs..."
mkimage -A arm -O linux -T ramdisk -C gzip -n "Custom Initramfs" -d build/initramfs-custom.gz build/initramfs.uimg

echo "Coping initramfs to TFTP..."
sudo cp -v build/initramfs.uimg /srv/tftp/initramfs.uimg
