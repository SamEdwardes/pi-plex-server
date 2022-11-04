refresh:
    sudo apt-get update
    sudo apt-get upgrade

restart:
    sudo reboot

shutdown:
    sudo shutdown -h now

install-plex:
    # https://linuxhint.com/install-plex-raspberry-pi-4/
    curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
    sudo apt update
    sudo apt install -y apt-transport-https
    echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
    sudo apt update
    sudo apt install -y plexmediaserver

hostname:
    hostname -I

mount-usb:
    sudo mount /dev/sda1 ~/usbstick


fix-permissions-for-plex:
    sudo chmod go+xr /home/ubuntu/

# Install and configure NFS
nfs-install:
    # https://pimylifeup.com/raspberry-pi-nfs/
    sudo apt-get install -y nfs-kernel-server
    sudo mkdir /mnt/nfsshare
    sudo chown -R ubuntu:ubuntu /mnt/nfsshare
    sudo find /mnt/nfsshare/ -type d -exec chmod 755 {} \;
    sudo find /mnt/nfsshare/ -type f -exec chmod 644 {} \;
    # /etc/exports
    # /mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)
    sudo exportfs -ra

nfs-update:
    sudo export -ra
