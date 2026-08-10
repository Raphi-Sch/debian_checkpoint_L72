#!/bin/sh

sudo debootstrap \
  --arch=armhf \
  --foreign \
  --include=kmod,net-tools,iproute2,openssh-server,nano,wget,curl,bash-completion \
  bullseye \
  ../debian-armhf \
  http://deb.debian.org/debian


# Copy QEMU ARM binary into the chroot so ARM ELFs can execute
sudo cp /usr/bin/qemu-arm-static ../debian-armhf/usr/bin/

# Enter the chroot and finish debootstrap
sudo chroot ../debian-armhf /usr/bin/qemu-arm-static /bin/bash -c "/debootstrap/debootstrap --second-stage"