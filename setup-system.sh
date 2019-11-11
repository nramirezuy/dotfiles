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
# sudo pacman --noconfirm --needed -S base-devel git vim

# Install yay (AUR helper)
echo 'Installing yay!'
cd /tmp
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd yay
makepkg --noconfirm -si
cd /tmp
rm -fr yay

# Install programs.csv
pacmaninstall() {
  sudo pacman --noconfirm --needed -S "$1" 
}

gitinstall() {
  dir=$(mktemp -d)
  git clone --depth 1 --shallow-submodules "$1" "$dir"
  cd "$dir"
  make
  sudo make install
  cd /tmp
  rm -fr "$dir"
}

while IFS=, read -r tag program comment; do
  if [ "$tag" = "TAG" ]; then
    continue
  fi

  echo "$program: $comment"
  case "$tag" in
    "PAC") pacmaninstall "$program" ;;
    "GIT") gitinstall "$program" ;;
  esac
done < programs.csv;
