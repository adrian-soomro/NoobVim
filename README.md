# Personalized nvim config

This repo serves two purposes
1) a quickstart when moving machines
2) a versioned back up of all config 

# Reqs

To get up and running, clone this repo to `~/.config/` and get the following:

## Binaries
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- LSP servers:
  - bash language server
     - shellcheck
	- [lua-language-server](https://github.com/sumneko/lua-language-server), good docs [here](https://www.chrisatmachine.com/blog/category/neovim/28-neovim-lua-development)
- [glow](https://github.com/charmbracelet/glow#installation)

## Miscelaneous
Some of the plugins rely on a Nerd font, [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) will have a nice one. 

once done, source [init.lua](./init.lua), perform a `:PackerSync` command 

### WSL2 Specific
With regards to the [font requirement](#Miscelaneous) - the fonts need to be installed on the host machine, and set for WSL2 directly in the properties of the WSL2 app.

# Suggestions
- telescope-repos - loads git repos to telescope
- mfussenegger/nvim-dap - debugger
- glepnir- dashboard
