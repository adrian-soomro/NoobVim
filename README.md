# NoobVim

A nvim config for absolute ~~noobs~~ beginners

# Reqs
You'll need to be on a *Nix system, WSL2 works too

To get up and running, clone this repo to your `~/.config/` and get the following:

## Binaries
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [glow](https://github.com/charmbracelet/glow#installation)
- LSP servers:
  - [bash language server](https://github.com/typescript-language-server/typescript-language-server#installing)
     - [shellcheck](https://github.com/typescript-language-server/typescript-language-server#installing)
  - [lua-language-server](https://github.com/sumneko/lua-language-server), good docs [here](https://www.chrisatmachine.com/blog/category/neovim/28-neovim-lua-development)
  - [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server#installing) for both JS and TS

## Miscelaneous
- Some of the plugins rely on a Nerd font, [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) will have a nice one. 

once done, source [init.lua](./init.lua) and perform a `:PackerSync` command 

### WSL2 Specific
- With regards to the [font requirement](#Miscelaneous) - the fonts need to be installed on the host machine, and set for WSL2 directly in the properties of the WSL2 app.
- Installing [VcXsrv](https://youtu.be/_MgrjgQqDcE?t=755) is highly recommended - this will allow you to share os clipboard between WSL2 host and the WSL2 instance, so that it can be used in nvim, just note that you'll also need to set up `DISPLAY` env var in your bash/zsh.rc and [pass `-ac` as additional argument to VcXsrv](https://github.com/microsoft/WSL/issues/4106#issuecomment-502345378)

# Suggestions
- telescope-repos - loads git repos to telescope
- mfussenegger/nvim-dap - debugger

# TODO
- fix lspsaga outline window not showing objects
- configure luasnip 
