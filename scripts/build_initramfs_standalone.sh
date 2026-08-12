#!/bin/sh

echo "Compressing initramfs..."
(cd ../kernel/original/initramfs; sudo find . | sudo cpio -H newc -o | gzip -9 > ../_initramfs.gz)

echo "Packing initramfs..."
cd ../kernel/original/initramfs
mkimage -A arm -O linux -T ramdisk -C gzip -n "Custom Initramfs" -d ../_initramfs.gz ../_initramfs.uimg

while true; do
    read -p "Do you want to copy 'initramfs.uimg' to '/srv/tftp' [Y/N] : " yn
    case $yn in
        [Yy]* ) echo "Copying file to tftp..."; sudo cp -v ../_initramfs.uimg /srv/tftp/initramfs.uimg; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no;";;
    esac
done
