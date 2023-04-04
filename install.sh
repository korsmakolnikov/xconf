#!/bin/bash
# TODO refactor like a list of function to call and parse cmd args for spot installations

# Installing common utils
read -p "I'm going to install common utils. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo pacman --noconfirm -S curl
	sudo pacman --noconfirm -S gping
	sudo pacman --noconfirm -S procs
  # mcfly isn't working properly anymore
  #sudo curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
fi

# Installing common 
read -p "I'm going to install common dependency. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo pacman --noconfirm -S ripgrep
	sudo pacman --noconfirm -S ttf-fira-code
fi

# Installing asdf and language
read -p "I'm going to install Erlang and asdf. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo pacman --noconfirm -S asdf-vm
  sudo pacman --noconfirm -S erlang
fi

# Installing vim
read -p "I'm going to install vim, vim-plug, vim conf. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo pacman --noconfirm -S vim
  rm -rf $HOME/.vim/
  rm $HOME/.vimrc
	ln -s $PWD/.vimrc $HOME/.vimrc
  ln -s $PWD/vim-config $HOME/.vim-config
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -s $PWD/coc-settings.json $HOME/.vim/coc-settings.json
fi

# Installing neovim
read -p "I'm going to install neovim and packer. Are you sure? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo pacman --noconfirm -S neovim
	#sudo pacman --noconfirm -S python3-neovim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  	~/.local/share/nvim/site/pack/packer/start/packer.nvim
	ln -s $PWD/nvim $HOME/.config/nvim
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
	sudo pacman --noconfirm -S kitty
  mkdir -p $HOME/.config/kitty
	ln -s $PWD/kitty.conf $HOME/.config/kitty/kitty.conf
  chsh
  sudo chsh
fi
