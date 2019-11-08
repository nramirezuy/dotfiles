#!/bin/sh -e

echo 'setup-system'

# Use all cores for compilation
sudo sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Prettify pacman
sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf > /dev/null ||
  sudo sed -i "/^Color/a ILoveCandy" /etc/pacman.conf

# Refresh keyring
pacman --noconfirm -Sy archlinux-keyring

# Install basics
pacman --noconfirm --needed -S base-devel git vim

# Install yay (AUR helper)
cd /tmp
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd yay
makepkg --noconfirm -si
cd /tmp
rm -fr yay

pacmaninstall() {
  pacman --noconfirm --needed -S "$1" 
}

# Install programs.csv
while IFS=, read -r tag program comment; do
  if [ "$tag" -eq "TAG" ]; then
    continue
  fi

  echo "$program: $comment"
  case "$tag" in
    "PAC") pacmaninstall "$program" ;;
  esac
done < programs.csv;
