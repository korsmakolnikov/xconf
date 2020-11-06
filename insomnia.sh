#! /bin/bash

cd $(mktemp -d)
wget https://aur.archlinux.org/cgit/aur.git/snapshot/insomnia.tar.gz
tar xzf insomnia.tar.gz
cd insomnia
makepkg -si
