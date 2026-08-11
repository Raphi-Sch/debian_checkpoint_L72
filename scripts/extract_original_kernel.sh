#!/bin/sh

mkdir -p ../kernel/3.10/

if [ -f "../img/linux_kernel.bin" ] then
    echo "Copying kernel from 'img/linux_kernel.bin' to 'kernel/3.10/kerne.bin'..."
    dd if=../img/linux_kernel.bin of=../kernel/3.10/kernel-3.10.bin bs=4096 skip=1

    echo "Extracting kernel..."
    (cd ../kernel/3.10/; binwalk -e kernel-3.10.bin)
    
else
    echo "'linux_kernel.bin' don't exist.\nFirst run 'on_device/nand_to_img.sh' on the device and then copy them into the folder img/"
fi

exit

# Let binwalk identify ALL signatures
binwalk kernel.bin

dd if=46F4 bs=1 skip=7954472 of=initramfs.gz

gunzip -c initramfs.gz > initramfs.cpio

file initramfs.cpio

mkdir initramfs/
cd initramfs/
cpio -id < ../initramfs.cpio