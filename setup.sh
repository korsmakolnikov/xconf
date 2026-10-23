#!/bin/bash

bash_profile="$HOME/.bash_profile"
if [ -f "$bash_profile" ]; then
	mv "$bash_profile" "$bash_profile.bak"
fi
ls -A bash_conf | xargs -I {} ln -s -v -f $PWD/bash_conf/{} $HOME/{}

grep -q "source $HOME/.bash_profile" "$bash_profile"
if [ $? -ne 0 ]; then
	echo "source $HOME/.bash_profile" >> "$HOME/.bashrc"
fi

wezterm_file="$HOME/.wezterm.lua"

#wezterm
if [ -f "$wezterm_file" ]; then
	if [ -f "$HOME/wezterm.bak" ]; then
		rm "$HOME/wezterm.bak"
	fi
	mv "$wezterm_file" "$HOME/wezterm.bak"
fi
ln -s "$PWD/wezterm.lua" "$wezterm_file"

#picom
picom_file="$HOME/.config/picom.conf"
if [ -f "$picom_file" ]; then
	if [ -f "$HOME/.config/picom.bak" ]; then
		rm "$HOME/.config/picom.bak"
	fi

	mv "$picom_file" "$HOME/.config/picom.bak"
fi
ln -s "$PWD/picom.conf" "$picom_file"

#i3
i3_config_folder="$HOME/.config/i3"
if [ ! -d "$i3_config_folder" ]; then
	mkdir -p "$i3_config_folder"
fi

i3_config="$HOME/.config/i3/config"
if [ -f "$i3_config" ]; then
	if [ -f "$HOME/.config/i3/config.bak" ]; then
		rm "$HOME/.config/i3/config.bak"
	fi
	mv "$i3_config" "$HOME/.config/i3/config.bak"
fi
ln -s "$PWD/i3.conf" "$i3_config"

#rgs
rgs_file="/$HOME/.local/bin/rgs"
if [ ! -f "$rgs_file" ]; then
	sudo ln -s rgs.sh "$rgs_file"
fi

# packages
sudo groupadd docker
sudo usermod -aG docker $USER 
newgrp docker
sudo pacman -Syu --noconfirm docker
sudo pacman --noconfirm -S docker-compose
systemctl enable docker.service
systemctl start docker.service

sudo pacman --noconfirm -S ripgrep
sudo pacman --noconfirm -S asdf-vm
sudo pacman --noconfirm -S discord
sudo pacman --noconfirm -S slack-desktop
sudo pacman --noconfirm -S vlc
sudo pacman --noconfirm -S gopls
sudo pacman --noconfirm -S delve
sudo pacman --noconfirm -S lua-language-server

asdf plugin add golang
asdf plugin add nodejs
asdf install golang 1.16.15
asdf install nodejs 16.14.2
asdf global golang 1.16.15
asdf global nodejs 16.14.2 
