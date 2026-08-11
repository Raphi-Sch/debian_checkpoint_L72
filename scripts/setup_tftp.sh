# Install servers
sudo apt install tftpd-hpa

# TFTP — serve kernel and DTB
sudo mkdir -p /srv/tftp
sudo chown -R tftp:tftp /srv/tftp

# Configure TFTP
sudo sed -i 's|TFTP_DIRECTORY=.*|TFTP_DIRECTORY="/srv/tftp"|' /etc/default/tftpd-hpa
sudo systemctl restart tftpd-hpa