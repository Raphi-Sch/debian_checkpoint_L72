#!/bin/sh

sudo mkdir -p /srv/tftp/

if [ -f "../img/linux_kernel.bin" ] & [ -f "../img/device_tree.bin" ]; then
    echo "Copying kernel to tftp..."
    sudo dd if=../img/device_tree.bin of=/srv/tftp/dt.img
    sudo dd if=../img/linux_kernel.bin of=/srv/tftp/uImage bs=4096 skip=1
    sync
else
    echo "'linux_kernel.bin' or 'device_tree.bin' don't exist.\nFirst run 'nand_to_usb.sh' on the device and then copy them into the folder img/"
fi