#!/bin/sh -e

# Ask user for hostname to use
read -p 'Enter a hostname: ' HOSTNAME

# Ark use for timezone
TIMEZONE=$(tzselect)

# Ask user an unmounted drive and that exists
DRIVE=''
while grep -o "$DRIVE" /proc/mounts > /dev/null || ! ls $DRIVE > /dev/null; do
  lsblk
  read -p "Select an unmounted device to setup the installer: " DRIVE
done

# Ask user for partition sizes
MEMSIZE=$(cat /proc/meminfo | grep -Po "MemTotal: +\K([0-9]+)")
echo 'Enter partition sizes' 
read -ep 'Enter boot size: ' -i '300M' BOOT
read -ep 'Enter swap size: ' -i $(echo "$MEMSIZE / 1000^2 * 1.5" | bc)"G" SWAP
read -ep 'Enter root size: ' -i '25G' ROOT

timedatectl set-ntp true

# Destroy disk and create partitions
dd if=/dev/zero of=$DRIVE bs=512 count=1
wipefs --all --force $DRIVE
cat << EOF | fdisk $DRIVE
o
n
p


+$BOOT
n
p


+$SWAP
n
p


+$ROOT
n
p


w
EOF

# Notify the kernel partitions were updated
partprobe -s $DRIVE

# Format partions
yes | mkfs.btrfs -f $DRIVE"4"
yes | mkfs.btrfs -f $DRIVE"3"
yes | mkfs.btrfs -f $DRIVE"1"
mkswap $DRIVE"2"
swapon $DRIVE"2"

# Mount partitions
mount $DRIVE"3" /mnt
mkdir -p /mnt/boot
mount $DRIVE"1" /mnt/boot
mkdir -p /mnt/home
mount $DRIVE"4" /mnt/home

# Install keyring
pacman -Sy --noconfirm archlinux-keyring

# Install Arch and packages :yay:
pacstrap /mnt base base-devel linux linux-firmware

# Generate fstab file
genfstab -U /mnt > /mnt/etc/fstab

# Write hostname to disk
echo $HOSTNAME > /mnt/etc/hostname

echo 'Executing chroot.sh'
if [ -f chroot.sh ]; then
  cp chroot.sh /mnt/chroot.sh
  arch-chroot /mnt bash chroot.sh $TIMEZONE $DRIVE
fi
