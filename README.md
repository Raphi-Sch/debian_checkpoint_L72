# Debian on CheckPoint L72 (770) Firewall Appliance

## Device specifications
- CPU  : 4 cores ARMv7 @ 1.7Ghz
- RAM  : 2048 MiB
- NAND : 2048 MiB
- ETH  : 4 ports accessible directly (WAN/DMZ), 16 behind PCIe device 
- USB : 2 USB 3.0 ports
- CONSOLE : RJ45 (Cisco) + USB MiniB

## Boot options

### Boot from TFTP uImage (kernel) and USB root drive

```sh
fw_setenv bootcmd 'boot_init_before_kernel; setenv bootargs root=/dev/sda2 ip=[DEVICE-IP]:[TFTP-IP]:[GATEWAY]:[NETMASK]:checkpoint:eth1:none console=ttyS0,115200 pci=pcie_bus_perf mem=2046M rdinit=/bin/sh; tftpboot $loadaddr_payload ${tftpdir}uImage; bootm $loadaddr_payload - $fdtaddr'
```

Replace [DEVICE-IP], [TFTP-IP], [GATEWAY] and [NETMASK]