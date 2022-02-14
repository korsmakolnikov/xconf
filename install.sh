#!/bin/bash

$distro_is_manjaro=lsb_release -a | cut -d ":" -f 2 | tr -d "[:blank:]" | grep -Pzo Manjaro

if [[ -z "$distro_is_manjaro" ]]; then
  install_me='yay -S'
else
  install_me='sudo apt install -y'
fi

# Installing common utils
read -p "I'm going to install common utils. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	$install_me curl
  if [ ! [ -z "$distro_is_manjaro" ]]; then
    echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
    wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
    sudo apt update
  fi
	$install_me gping
	$install_me procs
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly
fi

# Installing common 
read -p "I'm going to install common dependency. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
  $install_me ripgrep
	$install_me ttf-fira-code
fi

# Installing asdf and language
read -p "I'm going to install Erlang and asdf. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	$install_me asdf-vm
  if [[ -z "$distro_is_manjaro" ]]; then
    sudo pacman -S erlang
  else
    $install_me erlang
  fi
fi

# Installing vim
read -p "I'm going to install vim, vim-plug, nodejs. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	$install_me vim
	$install_me nodejs-lts-fermium
  $install_me npm
	ln -s $PWD/.vimrc $HOME/.vimrc
  ln -s $PWD/.vim/ $HOME/.vim-config/
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -s $PWD/coc-settings.json $HOME/.vim/coc-settings.json
fi

# Installing bash support
read -p "I'm going to install bash configuration. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
  mv $HOME/.bash_profile $HOME/.bash_profile.bak
	ls -A bash_conf | xargs -I {} ln -s -v -f $PWD/bash_conf/{} $HOME/{}
  echo "source $HOME/.bash_profile" >> $HOME/.bashrc
fi

# Installing kitty and its conf
read -p "I'm going to install kitty configuration. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	$install_me kitty
	ln -s $PWD/kitty.conf $HOME/.config/kitty/kitty.conf
fi
