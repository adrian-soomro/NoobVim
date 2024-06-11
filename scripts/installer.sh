SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Getting dependencies"
"$SCRIPT_DIR/dependency-installer.sh"

echo "installing NoobVim"
"$SCRIPT_DIR/noobvim-installer.sh"

cd "$HOME"
rm -rf "$OLDPWD"
