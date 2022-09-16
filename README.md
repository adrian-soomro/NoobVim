# NoobVim

A nvim config for absolute ~~noobs~~ beginners

# 🎯 Aim
To provide easy transition from mainstream IDEs into NeoVim

# 📜 Requirements
You'll need to be on a *Nix system, WSL2 works too

# 🚀 Getting started
To get up and running, clone this repo to your `~/.config/` and get the following:

## Binaries
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [glow](https://github.com/charmbracelet/glow#installation)
- LSP servers (skip any that you're not interested in):
  - [bash language server](https://github.com/bash-lsp/bash-language-server#installation)
     - [shellcheck](https://github.com/koalaman/shellcheck#installing)
  - [lua-language-server](https://github.com/sumneko/lua-language-server), good docs [here](https://www.chrisatmachine.com/blog/category/neovim/28-neovim-lua-development)
  - [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server#installing) for both JS and TS
  - [marksman](https://github.com/artempyanykh/marksman#how-to-install) for markdown
  - [dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server-nodejs#installation-instructions) for Dockerfile
  - [terraform-ls](https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md#installation) for terraform
  - [vscode-json-language-server](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls) for JSON

# Using code runner
you can run your project in a single keypress, similar to other popular IDEs. To do so, you'll first need to tell [code_runner](https://github.com/CRAG666/code_runner.nvim#add-projects) how to run your project.

*NB* you'll need to be in the project's directory for this to work as expected.

## ❓ Miscelaneous
- Some of the plugins rely on a Nerd font, [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) will have a nice one. 

once done, source [init.lua](./init.lua) and perform a `:PackerSync` command 

### WSL2 Specific
- With regards to the [font requirement](#Miscelaneous) - the fonts need to be installed on the host machine, and set for WSL2 directly in the properties of the WSL2 app.
- Installing [VcXsrv](https://youtu.be/_MgrjgQqDcE?t=755) is highly recommended - this will allow you to share os clipboard between WSL2 host and the WSL2 instance, so that it can be used in nvim, just note that you'll also need to set up `DISPLAY` env var in your bash/zsh.rc and [pass `-ac` as additional argument to VcXsrv](https://github.com/microsoft/WSL/issues/4106#issuecomment-502345378)
- Accessing your WSL2 instance through the windows [Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) app is recommended, as this terminal emulator supports italics and other styles of text, while having richer support for nerd-fonts

# Suggestions
- telescope-repos - loads git repos to telescope

# TODO
- fix lspsaga outline window not showing objects
- configure luasnip 
