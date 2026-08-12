#!/bin/sh

mkdir -p ../kernel/original/

if [ -f "../img/linux_kernel.bin" ]; then
    echo "Copying kernel from '../img/linux_kernel.bin' to '../kernel/original/kernel.bin'..."
    dd if=../img/linux_kernel.bin of=../kernel/original/uImage bs=4096 skip=1 # The fist 4096 bytes are vendor comments
    cd ../kernel/original/
    dd if=uImage of=kernel.bin bs=64 skip=1 # The next 64 bytes are uImage header

    echo "Extracting kernel..."
    if [ -d "./_kernel.bin.extracted" ]; then
        echo "Removing previous extraction..."
        rm -R _kernel.bin.extracted
    fi
    binwalk -e kernel.bin

    echo "Extracting initramfs..."
    dd if=_kernel.bin.extracted/46F4 bs=1 skip=7689196 of=initramfs.gz

    echo "Decompressing initramfs..."
    gunzip -c initramfs.gz > initramfs.cpio

    echo "Unpacking initramfs..."
    if [ -d "./initramfs" ]; then
        echo "Removing previous version..."
        sudo rm -R initramfs
    fi
    (mkdir initramfs; cd initramfs/; sudo cpio -id < ../initramfs.cpio)

    echo "Cleanup..."
    rm initramfs.cpio initramfs.gz kernel.bin uImage
else
    echo "'linux_kernel.bin' don't exist.\nFirst run 'nand_to_usb.sh' on the device and then copy them into the folder img/"
fi

exit