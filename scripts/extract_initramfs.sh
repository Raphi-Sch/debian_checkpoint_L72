#!/bin/sh

# Get the raw kernel payload (strip 64-byte uImage header)
dd if=uImage bs=64 skip=1 of=kernel.bin

# Let binwalk identify ALL signatures
binwalk kernel.bin

binwalk -e kernel.bin

dd if=46F4 bs=1 skip=7954472 of=initramfs.gz

gunzip -c initramfs.gz > initramfs.cpio

file initramfs.cpio

mkdir initramfs/
cd initramfs/
cpio -id < ../initramfs.cpio

