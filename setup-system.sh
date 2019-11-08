#!/bin/sh -e

echo 'setup-system'

# Use all cores for compilation
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Prettify pacman
sed -i "s/^#Color/Color/" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf > /dev/null ||
  sed -i "/^Color/a ILoveCandy" /etc/pacman.conf

# Refresh keyring
pacman --noconfirm -Sy archlinux-keyring

# Install basics
pacman --noconfirm --needed -S base-devel git vim

# Install yay
su $USERNAME <<EOF
  cd /tmp &&
  git clone https://aur.archlinux.org/yay.git &&
  cd yay &&
  makepkg --noconfirm -si &&
  cd /tmp &&
  rm -fr yay
EOF
