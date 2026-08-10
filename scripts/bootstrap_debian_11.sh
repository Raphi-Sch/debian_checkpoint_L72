#!/bin/sh

mkdir ../debian11-armhf

sudo debootstrap \
  --arch=armhf \
  --foreign \
  --include=nano,openssh-server,kmod,wget,bash-completion \
  bullseye \
  ../debian11-armhf \
  http://deb.debian.org/debian


# Copy QEMU ARM binary into the chroot so ARM ELFs can execute
sudo cp /usr/bin/qemu-arm-static ../debian11-armhf/usr/bin/

# Enter the chroot and finish debootstrap
sudo chroot ../debian11-armhf /usr/bin/qemu-arm-static /bin/bash -c "/debootstrap/debootstrap --second-stage"