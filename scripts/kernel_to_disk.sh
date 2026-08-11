#!/bin/sh

./mount_disk.sh

if [ -f "../img/linux_kernel.bin" ] & [ -f "../img/device_tree.bin" ]; then
    echo "Extracting kernel from img..."
    sudo dd if=../img/device_tree.bin of=/mnt/cpboot/boot/dt.img
    sudo dd if=../img/linux_kernel.bin of=/mnt/cpboot/boot/uImage bs=4096 skip=1
    sync
else
    echo "'linux_kernel.bin' or 'device_tree.bin' don't exist.\nFirst run 'on_device/nand_to_img.sh' on the device and then copy them into the folder img/"
fi

./umount_disk.sh