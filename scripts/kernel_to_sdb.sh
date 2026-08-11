#!/bin/sh
if [ -f "../img/linux_kernel.bin" ] & [ -f "../img/device_tree.bin" ]; then
    echo "Mounting '/dev/sdb1' to '/mnt/cpboot'..."
    sudo mount /dev/sdb2 /mnt/cpboot

    echo "Extracting kernel from img..."
    dd if=../img/device_tree.bin of=/mnt/cpboot/boot/dt.img
    dd if=../img/linux_kernel.bin of=/mnt/cpboot/boot/uImage bs=4096 skip=1
    sync

    echo "Unmonting '/mnt/cpboot'..."
    sudo umount /mnt/cpboot
    exit
else
    echo "'linux_kernel.bin' or 'device_tree.bin' don't exist.\nFirst run 'on_device/nand_to_img.sh' on the device and then copy them into the folder img/"
    exit
fi