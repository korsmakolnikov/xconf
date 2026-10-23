asdf plugin add rust
asdf plugin add rebar
asdf install rust 1.58.1
asdf install rust 1.59.0
asdf global rust 1.58.1 
sudo pacman --noconfirm -S rust-analyzer
sudo pacman --noconfirm -S elm-language-server
sudo pacman --noconfirm -S python-pip
sudo pacman --noconfirm -S k9s
sudo pacman --noconfirm -S pgcli
sudo pacman --noconfirm -S aws-vault
go get -v github.com/dcoker/biscuit
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# docker

xdg-mime default firefox.desktop x-scheme-handler/https x-scheme-handler/http
