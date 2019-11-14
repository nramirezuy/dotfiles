#!/bin/sh -e

echo 'setup-system'

# Use all cores for compilation
sudo sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Prettify pacman
sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf > /dev/null ||
  sudo sed -i "/^Color/a ILoveCandy" /etc/pacman.conf

# Refresh keyring
echo 'Updating keyring'
sudo pacman --noconfirm -Sy archlinux-keyring

# Install basics
sudo pacman --noconfirm --needed -S base-devel git vim

# Install yay (AUR helper)
echo 'Installing yay!'
cd /tmp
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd yay
makepkg --noconfirm -si
cd /tmp
rm -fr yay

# Install packages
for package in $(ls packages); do
  packages/$package/install.sh
done
