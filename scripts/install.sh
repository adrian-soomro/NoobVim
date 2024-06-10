#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
function installEssentials() {
  sudo apt-get update
  sudo apt-get install build-essential procps wget file git cmake unzip python3-pip python3-venv xclip -y
}

function installBrew() {
  echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "$HOME/.profile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  source "$HOME/.profile"
}

function installPacker() {
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
}

function installNode() {
  brew install nvm
  if [ ! -d "$HOME/.nvm" ]; then
    mkdir "$HOME/.nvm"
  fi
  (echo; echo 'export NVM_DIR="$HOME/.nvm"') >> "$HOME/.profile"
  (echo; echo '[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm') >> ~/.profile
  (echo; echo '[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion') >> "$HOME/.profile"
  
  source "$HOME/.profile"
  nvm install 18 
  npm i -g yarn
}

function installOtherBinaries() {
  brew install ripgrep glow fd java dotnet@6 go
  
  installNode
}

function installNvim() {
  mkdir -p "$SCRIPT_DIR/tmp"
  pushd "$SCRIPT_DIR/tmp"
  wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz
  tar xzf nvim-linux64.tar.gz
  sudo mv nvim-linux64/bin/nvim /usr/bin/
  sudo mv nvim-linux64/lib/nvim/ /usr/lib/
  sudo mv nvim-linux64/share/nvim /usr/share/
  popd
}

installEssentials
installBrew
installPacker
installOtherBinaries
installNvim

bash "$SCRIPT_DIR/noobvim-install.sh"

