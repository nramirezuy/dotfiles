#!/bin/sh -e

# Ask user for root password
passwd

# Set timezone
TIMEZONE=$1
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Set RTC clock
hwclock --systohc

# Set locale
cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
en_US.UTF-8 UTF-8
es_UY.UTF-8 UTF-8
EOF

cat << EOF > /etc/locale.conf
LANG=en_US.UTF-8
LC_ADDRESS=es_UY.UTF-8
LC_IDENTIFICATION=es_UY.UTF-8
LC_MEASUREMENT=es_UY.UTF-8
LC_MONETARY=es_UY.UTF-8
LC_NAME=es_UY.UTF-8
LC_NUMERIC=es_UY.UTF-8
LC_PAPER=es_UY.UTF-8
LC_TELEPHONE=es_UY.UTF-8
LC_TIME=es_UY.UTF-8
EOF

locale-gen

# Install vim (the true text editor)
pacman --noconfirm --needed -S vim

# Install and setup NetworkManager
pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager

# Install and setup GRUB
DRIVE=$2
pacman --noconfirm --needed -S grub
grub-install --target=i386-pc $DRIVE
grub-mkconfig -o /boot/grub/grub.cfg
