asdf plugin add rust
asdf plugin add rebar
asdf plugin add golang
asdf plugin add nodejs
asdf install rust 1.58.1
asdf install rust 1.59.0
asdf install golang 1.16.15
asdf install nodejs 16.14.2
asdf global golang 1.16.15
asdf global rust 1.58.1 
asdf global nodejs 16.14.2 
sudo pacman --noconfirm -S rust-analyzer
sudo pacman --noconfirm -S gopls
sudo pacman --noconfirm -S delve
sudo pacman --noconfirm -S elm-language-server
sudo pacman --noconfirm -S lua-language-server
sudo pacman --noconfirm -S python-pip
sudo pacman --noconfirm -S k9s
sudo pacman --noconfirm -S pgcli
sudo pacman --noconfirm -S aws-vault
go get -v github.com/dcoker/biscuit
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# docker
sudo groupadd docker
sudo usermod -aG docker $USER 
newgrp docker
sudo pacman -Syu docker
systemctl enable docker.service
systemctl start docker.service

xdg-mime default firefox.desktop x-scheme-handler/https x-scheme-handler/http
