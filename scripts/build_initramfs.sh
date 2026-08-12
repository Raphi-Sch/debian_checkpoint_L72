#!/bin/sh
set -e

INITRAMFS_OFFSET=7954472
LAST_OFFSET=13468608
KERNEL_SRC=_kernel.bin.extracted/46F4
ZIMAGE_GZIP_OFFSET=18164   # 0x46F4

echo "Compressing initramfs..."
(cd ../kernel/original/initramfs
 sudo find . | sudo cpio -H newc -o | gzip -9 > ../_initramfs.gz)

cd ../kernel/original/

echo "Extracting last block..."
dd if=$KERNEL_SRC of=_last bs=1 skip=$LAST_OFFSET

echo "Extracting before block..."
dd if=$KERNEL_SRC of=_new_kernel.bin bs=1 count=$INITRAMFS_OFFSET

echo "Appending new initramfs..."
dd if=_initramfs.gz of=_new_kernel.bin bs=1 seek=$INITRAMFS_OFFSET conv=notrunc

ORIG_SIZE=$((13468608 - 7954472))
CUSTOM_SIZE=$(wc -c < _initramfs.gz)
PAD=$((ORIG_SIZE - CUSTOM_SIZE))

dd if=/dev/zero bs=1 count=$PAD >> _initramfs.gz

echo "Original initramfs : $ORIG_SIZE bytes"
echo "Custom initramfs   : $CUSTOM_SIZE bytes"
echo "Padding needed     : $PAD bytes"
echo "Padded size        : $(wc -c < _initramfs.gz) bytes"

echo "Appending last block..."
OUTPUT_LENGTH=$(stat -c %s _new_kernel.bin)
dd if=_last of=_new_kernel.bin bs=1 seek=$OUTPUT_LENGTH conv=notrunc
 
echo ""
echo "Sizes:"
echo "  Before block : $INITRAMFS_OFFSET bytes"
echo "  Initramfs    : $(wc -c < _initramfs.gz) bytes"
echo "  Last block   : $(wc -c < _last) bytes"
echo "  Total        : $(wc -c < _new_kernel.bin) bytes"

echo "Verifying..."
binwalk _new_kernel.bin

echo "Compressing kernel..."
gzip -9 -c _new_kernel.bin > _new_kernel.gz

echo "Packing zImage..."
# Strip uImage header to get raw zImage
dd if=uImageOriginal bs=64 skip=1 of=original.zImage

# Splice new gzip into zImage
dd if=original.zImage of=new.zImage bs=1 count=$ZIMAGE_GZIP_OFFSET
dd if=_new_kernel.gz of=new.zImage bs=1 seek=$ZIMAGE_GZIP_OFFSET conv=notrunc

echo "Building uImage..."
mkimage -A arm -O linux -T kernel -C none \
  -a 0x00008000 -e 0x00008000 \
  -n "Linux-3.10.2_initramfs-1.0" \
  -d _new_kernel.bin \
  uImageCustom

while true; do
    read -p "Do you want to copy 'newImage' to '/srv/tftp' [Y/N] : " yn
    case $yn in
        [Yy]* ) echo "Copying file to tftp..."; sudo cp -v uImageCustom /srv/tftp/uImageCustom; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no;";;
    esac
done

exit;
