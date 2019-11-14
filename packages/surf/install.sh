#!/bin/sh
sudo pacman --noconfirm --needed -S gcr glib2 webkit2gtk

repo=https://github.com/nramirezuy/surf.git
initdir=$(PWD)
dir=$(mktemp -d)
git clone --depth 1 --shallow-submodules "$repo" "$dir"
cd "$dir"
make
sudo make install
cd $initdir
rm -fr "$dir"
