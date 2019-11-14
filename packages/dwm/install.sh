#!/bin/sh
sudo pacman --noconfirm --needed -S libx11 libxft libxinerama ttf-inconsolata

repo=https://github.com/nramirezuy/dwm.git
initdir=$(PWD)
dir=$(mktemp -d)
git clone --depth 1 --shallow-submodules "$repo" "$dir"
cd "$dir"
make
sudo make install
cd $initdir
rm -fr "$dir"
