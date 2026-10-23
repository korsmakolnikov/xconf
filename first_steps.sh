sudo pacman --noconfirm -S git
sudo pacman --noconfirm -S git-delta
sudo pacman --noconfirm -S tig
git config --global user.email "korsmakolnikov@gmail.com"
git config --global user.name "Federico Caprari"
git config --global core.editor "nvim"
read -p "git has been initialized, do you want to proced to install the minimal set of needed package"

sudo pacman --noconfirm -S wezterm
sudo pacman --noconfirm -S neovim
sudo pacman --noconfirm -S firefox
sudo pacman --noconfirm -S bash-completion
sudo pacman --noconfirm -S bat
sudo pacman --noconfirm -S curl
sudo pacman --noconfirm -S fzf
sudo pacman --noconfirm -S ripgrep
sudo pacman --noconfirm -S jq
sudo pacman --noconfirm -S htop
sudo pacman --noconfirm -S lsof
sudo pacman --noconfirm -S tree-sitter
sudo pacman --noconfirm -S ttf-fira-code
sudo pacman --noconfirm -S xclip
sudo pacman --noconfirm -S betterlockscreen

echo "creating a new ssh key for syncing with the github account"
chsh -s /usr/bin/bash 
ssh-keygen -t ed25519 -C "korsmakolnikov@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

read -p "If you have added the ssh key to your github account press enter to clone the configuration repositories"
git clone git@github.com:korsmakolnikov/xconf.git
git clone git@github.com:korsmakolnikov/xnvim.git
