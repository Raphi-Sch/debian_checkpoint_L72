#!/bin/sh

sudo mkdir -p /mnt/cpboot
sudo mkdir -p /mnt/cpdebian

echo "Mounting 'boot' on '/mnt/cpboot'"
sudo mount --uuid 6ca4ef5f-335d-4efe-8b47-bef2fc10360e /mnt/cpboot

echo "Mounting 'debian' on '/mnt/cpdebian'"
sudo mount --uuid 765fecd2-9eae-4d19-afd5-42c11e07b76f /mnt/cpdebian
