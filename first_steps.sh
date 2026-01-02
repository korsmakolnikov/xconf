sudo pacman --noconfirm -S git
sudo pacman --noconfirm -S firefox
sudo pacman --noconfirm -S wezterm
sudo pacman --noconfirm -S xclip
sudo pacman --noconfirm -S neovim
chsh -s /usr/bin/bash 
ssh-keygen -t ed25519 -C "korsmakolnikov@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
read -p "If you have added the ssh key to your github account press enter to clone the configuration repositories"
git clone git@github.com:korsmakolnikov/xconf.git
git clone git@github.com:korsmakolnikov/xnvim.git
