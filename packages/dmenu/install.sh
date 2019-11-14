#!/bin/sh
repo=https://github.com/nramirezuy/dmenu.git
initdir=$(PWD)
dir=$(mktemp -d)
git clone --depth 1 --shallow-submodules "$repo" "$dir"
cd "$dir"
make
sudo make install
cd $initdir
rm -fr "$dir"
