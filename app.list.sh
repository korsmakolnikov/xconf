#!/bin/bash

#pacman --noconfirm -S asdf-vm
pacman --noconfirm -S procs
#pacman --noconfirm -S aws-vault
pacman --noconfirm -S bash-completion
pacman --noconfirm -S bat
pacman --noconfirm -S curl
#pacman --noconfirm -S discord
#pacman --noconfirm -S docker
#pacman --noconfirm -S docker-compose
#pacman --noconfirm -S erlang
#pacman --noconfirm -S element-desktop
pacman --noconfirm -S fzf
#pacman --noconfirm -S git
pacman --noconfirm -S git-delta
#pacman --noconfirm -S helm
pacman --noconfirm -S htop
#pacman --noconfirm -S java-openjdk-ea-bin
pacman --noconfirm -S jq
#pacman --noconfirm -S k9s
#pacman --noconfirm -S kubectl
#pacman --noconfirm -S lldb
pacman --noconfirm -S lsof
#pacman --noconfirm -S minikube
#pacman --noconfirm -S neovim
#pacman --noconfirm -S npm
#pacman --noconfirm -S rabbitmq
#pacman --noconfirm -S redis
pacman --noconfirm -S ripgrep
#pacman --noconfirm -S rnnoise
#pacman --noconfirm -S slack-desktop
#pacman --noconfirm -S telegram-desktop
pacman --noconfirm -S tig
#pacman --noconfirm -S tor
#pacman --noconfirm -S tree-sitter
pacman --noconfirm -S ttf-fira-code
pacman --noconfirm -S usbimager
#pacman --noconfirm -S virtualbox
#pacman --noconfirm -S vlc
pacman --noconfirm -S xclip
#pacman --noconfirm -S wezterm
#pacman --noconfirm -S atuin
#pacman --noconfirm -S betterlockscreen
pacman --noconfirm -S autojump

#curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
#echo '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh' >> ~/.bashrc

#git config --global user.email "korsmakolnikov@gmail.com"
#git config --global user.name "Federico Caprari"
#git config --global core.editor "nvim"

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s "$PWD/nvim" "$HOME/.config/nvim"

mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
ls -A bash_conf | xargs -I {} ln -s -v -f $PWD/bash_conf/{} $HOME/{}
echo "source $HOME/.bash_profile" >> "$HOME/.bashrc"

#rofi theme
git clone --depth=1 https://github.com/adi1090x/rofi.git rofi-theme
chmod +x ~/rofi-theme/setup.sh
sh ~/rofi-theme/setup.sh 

#wezterm
#ln -s "$(pwd)/xconf/wezterm.lua" "$(pwd)/.wezterm.lua"

#chsh
#sudo chsh

#mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.bak"
#mv "$HOME/.config/i3status/config" "$HOME/.config/i3status/config.bak"
#mv "$HOME/.config/picom.conf" "$HOME/config/picom.bak"
#ln -s "$PWD/picom.conf" "$HOME/.config/picom.conf"
#ln -s "$PWD/i3.conf" "$HOME/.config/i3/config"
#ln -s "$PWD/i3status.conf" "$HOME/.config/i3status/config"
