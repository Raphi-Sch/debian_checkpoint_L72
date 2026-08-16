#!/bin/sh

sudo mkdir -p /mnt/cpdebian

echo "Mounting 'debian' on '/mnt/cpdebian'"
sudo mount --uuid ca8b3e5e-24d9-40c8-a41d-6b092327ea0b /mnt/cpdebian
