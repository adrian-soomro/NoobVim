#!/bin/bash

function installEssentials() {
  sudo apt-get install build-essential procps curl file git cmake unzip python3-pip python3-venv -y
}

function installBrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}

function installPacker() {
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

function installOtherBinaries() {
  brew install ripgrep glow fd java dotnet@7 dotnet@6 go
}

function installNvim() {
  startingDirectory="$(PWD)"
  mkdir -p ~/tmp
  cd ~/tmp
  wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz
  tar xvzf nvim-linux64.tar.gz
  sudo mv nvim-linux64/bin/nvim /usr/bin/
  sudo mv nvim-linux64/lib/nvim/ /usr/lib/
  sudo mv nvim-linux64/share/nvim /usr/share/
  cd "$startingDirectory"
}

function installNoobVim() {
  git clone https://github.com/adrian-soomro/NoobVim.git
  pathToConfigDirectory="$HOME/.config"
  if [ ! -d "$pathToConfigDirectory" ]; then
    mkdir -p "$pathToConfigDirectory"
  fi 

  mv NoobVim "$pathToConfigDirectory"/nvim
}

installEssentials
installBrew
installPacker
installOtherBinaries
installNvim
installNoobVim