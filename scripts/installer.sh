SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Getting dependencies"
./dependency-installer.sh

echo "installing NoobVim"
./noobvim-installer.sh
