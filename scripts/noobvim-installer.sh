SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function installNoobVim() {
  source "$HOME/.profile"
  git clone https://github.com/adrian-soomro/NoobVim.git
  pathToConfigDirectory="$HOME/.config"
  if [ ! -d "$pathToConfigDirectory" ]; then
    mkdir -p "$pathToConfigDirectory"
  fi 

  mv NoobVim "$pathToConfigDirectory"/nvim
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
}

function installAdditionalDependenciesWithMason() {
  source "$HOME/.profile"
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
  nvim --headless -c "MasonInstall debugpy" -c "qall"
}

function tidyUp() {
  source "$HOME/.profile"
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -u "$HOME/.config/nvim/lua/packer-config/init.lua"
  nvim --headless -E +'TSUpdateSync' +'quit'
   rm -rf "$SCRIPT_DIR/tmp"
   rm -rf "$SCRIPT_DIR/go"
}

function startReaper() {
  sleep 450 
  pid=$(ps aux | grep "nvim setup" | grep -v 'grep' | awk '{print $2}')
  kill "$pid" 
}

installNoobVim
installAdditionalDependenciesWithMason
tidyUp
startReaper & 
nvim setup
