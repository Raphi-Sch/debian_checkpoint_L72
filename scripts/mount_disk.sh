#!/bin/sh

sudo mkdir -p /mnt/cpboot
sudo mkdir -p /mnt/cpdebian

echo "Mounting 'boot' on '/mnt/cpboot'"
sudo mount --uuid 6ca4ef5f-335d-4efe-8b47-bef2fc10360e /mnt/cpboot

echo "Mounting 'debian' on '/mnt/cpdebian'"
sudo mount --uuid ca8b3e5e-24d9-40c8-a41d-6b092327ea0b /mnt/cpdebian
