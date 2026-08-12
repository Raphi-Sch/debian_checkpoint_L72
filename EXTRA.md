# Extra

## Boot options

### Boot from TFTP uImage (kernel) and USB root drive

```sh
fw_setenv bootcmd 'boot_init_before_kernel; setenv bootargs root=/dev/sda2 ip=[DEVICE-IP]:[TFTP-IP]:[GATEWAY]:[NETMASK]:checkpoint:eth1:none console=ttyS0,115200 pci=pcie_bus_perf mem=2046M rdinit=/bin/sh; tftpboot $loadaddr_payload ${tftpdir}uImage; bootm $loadaddr_payload - $fdtaddr'
```

Replace [DEVICE-IP], [TFTP-IP], [GATEWAY] and [NETMASK]