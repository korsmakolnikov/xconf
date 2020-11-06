#!/bin/bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s "$PWD/nvim" "$HOME/.config/nvim"

mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
ls -A bash_conf | xargs -I {} ln -s -v -f $PWD/bash_conf/{} $HOME/{}
echo "source $HOME/.bash_profile" >> "$HOME/.bashrc"

#wezterm
ln -s "$(pwd)/xconf/wezterm.lua" "$HOME/.wezterm.lua"

chsh
sudo chsh

#i3
mv "$HOME/.config/picom.conf" "$HOME/.config/picom.bak"
ln -s "$PWD/picom.conf" "$HOME/.config/picom.conf"

#picom
mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.bak"
ln -s "$PWD/i3.conf" "$HOME/.config/i3/config"

