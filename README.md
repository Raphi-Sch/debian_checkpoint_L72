# Debian on CheckPoint L72 (770) Firewall Appliance

## Device specifications
- CPU  : 4 cores ARMv7 @ 1.7Ghz
- RAM  : 2048 MiB
- NAND : 2048 MiB
- ETH  : 4 ports accessible directly (WAN/DMZ), 16 behind PCIe device 
- USB : 2 USB 3.0 ports
- CONSOLE : RJ45 (Cisco) + USB MiniB

# Getting started

## Prerequisite

- USB Mini-B cable to connect console or RJ45 (Cisco) console cable
- USB Drive formated as FAT32 or EXT3 (EXT4 is doable, but the kernel 3.10 doesn't recognise newer EXT4 args)

## 1. Boot in maintenance mode

- Connect console cable
- Connect device to power
- Using a terminal emulator (PuTTY, Picocom, ...), connect to the serial console (baudrate: 115200)
- Hit `CTRL+C` when prompted
- Choose `option 3`
- Maintenance mode is ready when you see the following : `[Expert@Gateway-ID-ABCDEFG]#`

If a maintenance password was set and you don't know it, do a factory reset of the device either by holding "FACTORY DEFAULT" for 10sec when pluging in the power or by choosing option 4 in the boot menu.

## 2. Dump NAND

- Copy 'nand_to_usb.sh' to the USB drive
- Boot into maintenance mode
- Plug USB drive on device, first partition of the drive is automatically mounted under `/mnt/usb1`
- Execute `cd /mnt/usb1; ./nand_to_usb.sh`, it should take a few minutes.
- Examine result, you should have 10 files.
- Unmount drive `umount /mne/usb1`
- Copy all files from USB drive to `img/` 

To confirmation your dump is working, you can try to boot the kernel image from a TFTP server.

- First, convert the raw dump into a uImage : `dd if=linux_kernel.bin of=uImage bs=4096 skip=1`. 
This is necessary because the first 4096bytes are vendor comments not a uImage header.
- Copy uImage to a TFTP server
- Reboot device. When prompted hit 'CTRL+C'
- Choose hidden `option b`
- Follow the instruction from device

## Boot options

### Boot from TFTP uImage (kernel) and USB root drive

```sh
fw_setenv bootcmd 'boot_init_before_kernel; setenv bootargs root=/dev/sda2 ip=[DEVICE-IP]:[TFTP-IP]:[GATEWAY]:[NETMASK]:checkpoint:eth1:none console=ttyS0,115200 pci=pcie_bus_perf mem=2046M rdinit=/bin/sh; tftpboot $loadaddr_payload ${tftpdir}uImage; bootm $loadaddr_payload - $fdtaddr'
```

Replace [DEVICE-IP], [TFTP-IP], [GATEWAY] and [NETMASK]