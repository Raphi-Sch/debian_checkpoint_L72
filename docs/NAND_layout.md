# NAND Layout

## RAW Mapping

dev | size | erasesize | name
-- | -- | -- | --
mtd0 | 0x00300000 | 0x00040000 | al_boot
mtd1 | 0x00100000 | 0x00040000 | device_tree
mtd2 | 0x01000000 | 0x00040000 | linux_kernel
mtd3 | 0x0dc00000 | 0x00040000 | ubifs
mtd4 | 0x01000000 | 0x00040000 | linux_kernel2
mtd5 | 0x0dc00000 | 0x00040000 | ubifs-2
mtd6 | 0x0c400000 | 0x00040000 | default-sw
mtd7 | 0x40000000 | 0x00040000 | logs
mtd8 | 0x00100000 | 0x00040000 | preset
mtd9 | 0x00100000 | 0x00040000 | adsl
mtd10 | 0x15e80000 | 0x00040000 | storage


## Linux Mapping

NAME | MAJ:MIN | RM | SIZE | RO | TYPE
-- | -- | -- | -- | -- | --
mtdblock0 | 31:0 | 0 | 3M | 0 | disk
mtdblock1 | 31:1 | 0 | 1M | 0 | disk
mtdblock2 | 31:2 | 0 | 16M | 0 | disk
mtdblock3 | 31:3 | 0 | 220M | 0 | disk
mtdblock4 | 31:4 | 0 | 16M | 0 | disk
mtdblock5 | 31:5 | 0 | 220M | 0 | disk
mtdblock6 | 31:6 | 0 | 196M | 0 | disk
mtdblock7 | 31:7 | 0 | 1G | 0 | disk
mtdblock8 | 31:8 | 0 | 1M | 0 | disk
mtdblock9 | 31:9 | 0 | 1M | 0 | disk
mtdblock10 | 31:10 | 0 | 350.5M | 0 | disk
