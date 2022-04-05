sudo pacman --noconfirm -S gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev

git clone "https://github.com/neovide/neovide"
cd neovide 
asdf local rust 1.59.0
argo build --release
sudo cp ./target/release/neovide /usr/local/bin/neovide
cd ..
rm -rf neovide
