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

# Enable ethernet module on kernel
echo "tg3" > /etc/modules-load.d/ethernet.conf

# Register username, password and create home
USERNAME=$3
PASSWORD=$4
useradd -m -g wheel -s /bin/bash "$USERNAME" > /dev/null 2>&1 ||
  useradd -m -G wheel "$USERNAME" && mkdir -p /home/"$USERNAME" &&
    chown "$USERNAME":wheel /home/"$USERNAME"
echo "$USERNAME":"$PASSWORD" | chpasswd

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
