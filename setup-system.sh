#!/bin/sh -e

echo 'setup-system'

USERNAME='&'
while ! echo "$USERNAME" | grep "^[a-z_][a-z0-9_-]*$" > /dev/null 2>&1 \
    || id -u "$USERNAME" > /dev/null 2>&1 ; do
  read -p "username: " USERNAME
done

PASSWORD=''
PASSWORD_TO_COMPARE='not a password'
while ! [ "$PASSWORD" = "$PASSWORD_TO_COMPARE" ] ; do
  read -sp "password: " PASSWORD
  echo
  read -sp "passwrod again: " PASSWORD_TO_COMPARE
  echo
done
unset PASSWORD_TO_COMPARE

# Register username, password and create home
useradd -m -g wheel -s /bin/bash "$USERNAME" > /dev/null 2>&1 ||
  useradd -m -G wheel "$USERNAME" && mkdir -p /home/"$USERNAME" &&
    chown "$USERNAME":wheel /home/"$USERNAME"
echo "$USERNAME":"$PASSWORD" | chpasswd
unset PASSWORD

# Refresh keyring
pacman --noconfirm -Sy archlinux-keyring

# Install basics
pacman --noconfirm --needed -S base-devel git vim

# Prettify pacman
sed -i "s/^#Color/Color" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf > /dev/null ||
  sed "/^Color/a ILoveCandy" /etc/pacman.conf

# Use all cores for compilation
sed -i "s/-j2/-j$(nproc);s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Install yay
su - $USERNAME &&
  cd /tmp &&
  git clone https://aur.archlinux.org/yay.git &&
  cd yay &&
  makepkg --noconfirm -si &&
  cd /tmp &&
  rm -fr yay &&
exit
