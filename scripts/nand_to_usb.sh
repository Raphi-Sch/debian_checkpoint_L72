#!/bin/sh

echo "Coping NAND to USB1..."

cd /mnt/usb1

fw_printenv > checkpoint.env

dd if=/dev/mtd0 of=al_boot.bin
dd if=/dev/mtd1 of=device_tree.bin
dd if=/dev/mtd2 of=linux_kernel.bin
dd if=/dev/mtd3 of=ubifs.bin
dd if=/dev/mtd4 of=linux_kernel2.bin
dd if=/dev/mtd5 of=ubifs2.bin
dd if=/dev/mtd6 of=default-sw.bin
dd if=/dev/mtd7 of=logs.bin
dd if=/dev/mtd8 of=preset.bin
dd if=/dev/mtd9 of=adsl.bin
dd if=/dev/mtd10 of=storage.bin

sync