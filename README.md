# pi-plex-server

Files for my Raspberry Pi Plex Server

## Day to day

### Shutdown, Restart, Unmount, Mount

```bash
# Turn off (wait for 10 beeps of the green light)
sudo poweroff

# Restart
sudo reboot

# Unmount USB
sudo umount /mnt/plex-usb

# Mount USB - will mount everything per /etc/fstab
sudo mount -a
```

### SSH

```bash
# Run a command
ssh pi@plexpi.local ls -la

# Or, SSH into the server
ssh pi@plexpi.local
```

### Copying Files

```bash
# Copy a single file
scp ~/movies/hello-world.mp4 pi@plexpi.local:/mnt/plex-usb/movies

# Copy a directory
scp -r ~/movies/hello pi@plexpi.local:/mnt/plex-usb/movies
```

## Setup

### OS

Install the Raspberry Pi Imager <https://www.raspberrypi.com/software/>.

### SSH

- <https://www.raspberrypi.com/documentation/computers/remote-access.html#passwordless-ssh-access>

```bash
ssh pi@plexpi.local
```

### Mount USB

- <https://raspberrytips.com/mount-usb-drive-raspberry-pi/>

```bash
sudo fdisk -l
# Device     Boot  Start       End   Sectors   Size Id Type
# /dev/sda1       522240 484519679 483997440 230.8G  c W95 FAT32 (LBA)

sudo ls -l /dev/disk/by-uuid/
# total 0
# lrwxrwxrwx 1 root root 15 Feb 26 20:40 37CA-39EC -> ../../mmcblk0p1
# lrwxrwxrwx 1 root root 10 Feb 26 21:09 C5F1-A0AD -> ../../sda1
# lrwxrwxrwx 1 root root 15 Feb 26 20:40 a4af13c6-d165-4cbd-a9f6-c961fef8255d -> ../../mmcblk0p2
sudo mkdir /mnt/plex-usb
```

### Install Plex

Instructions from <https://pimylifeup.com/raspberry-pi-plex-server/>:

```bash
# Install plex
# https://pimylifeup.com/raspberry-pi-plex-server/
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https
curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex-archive-keyring.gpg >/dev/null
echo deb [signed-by=/usr/share/keyrings/plex-archive-keyring.gpg] https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt-get update
sudo apt-get install -y plexmediaserver

# Add media folders
sudo mkdir -p /opt/plex/movies
sudo mkdir /opt/plex/tv
sudo mkdir /opt/plex/other
sudo chmod -R 777 /opt/plex
```

Other directions:

- <https://linuxhint.com/install-plex-raspberry-pi-4/>

### Mount USB

### Install NFS

```bash
# https://pimylifeup.com/raspberry-pi-nfs/
sudo apt-get install -y nfs-kernel-server
sudo mkdir /mnt/nfsshare
sudo chown -R ubuntu:ubuntu /mnt/nfsshare
sudo find /mnt/nfsshare/ -type d -exec chmod 755 {} \;
sudo find /mnt/nfsshare/ -type f -exec chmod 644 {} \;
# /etc/exports
# /mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)
sudo exportfs -ra
```




## Helpful resources

- Setup: <https://www.youtube.com/watch?v=u8bbp79haN4>
- Plex: <https://pimylifeup.com/raspberry-pi-plex-server/>

## Tips

- Run `sudo poweroff` to turn off. Wait until the green light stops flashing.


