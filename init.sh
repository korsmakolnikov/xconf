#!/bin/bash
sudo pacman --noconfirm -S vim
sudo pacman --noconfirm -S git
sudo pacman --noconfirm -S keychain
git config --global user.email "korsmakolnikov@gmail.com"
git config --global user.name "korsmakolnikov"
ssh-keygen -t ed25519 -C korsmakolnikov@gmail.com
keychain --eval id_ed25519
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
