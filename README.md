# NoobVim

A nvim config for absolute ~~noobs~~ beginners.

# 🎯 Aim
To provide easy transition from mainstream IDEs into NeoVim.

# 📜 Requirements
You'll need to be on a *Nix system, WSL2 works too.

<details>
  <summary><b><u> Introduction to Vim/Nvim </u></b></summary>

# Glossary of Vim/Nvim Terms

If you've used Vim before, whether as a plugin inside another IDE, or standalone, feel free to skip this section.

When searching for documentation of some feature, you'll probably stumble upon two ways of doing things - either with VimScript, or with Lua. For a bit of context - Vim/Nvim used to be configured with a .vimrc file, which was written entirely in [VimScript](http://vimdoc.sourceforge.net/htmldoc/usr_41.html#script). Luckily for us, Nvim now supports configuration through [Lua](https://lua.org/). 

## Modes

There are 7 modes that your editor can be in, however, the 3 most important ones are: NORMAL, INSERT and VISUAL.
[This article](https://irian.to/blogs/introduction-to-vim-modes/) gives a nice introduction to them. 

## Buffers, Windows and Tabs

Coming into Vim/Nvim, we'll need to let go of the notion that every file is openened in its own tab/window. Windows != Tabs and Windowns != Buffers (needless to say, Buffers != Tabs). 

[This article](https://alpha2phi.medium.com/neovim-for-beginners-managing-buffers-91367668ce7) does a good job of summing up the differences, but a TL;DR version:

- A buffer == file loaded to memory for editing, the file is unchanged until you save it (`:w` in NORMAL mode or `Ctrl+s` in any other mode)
- A window == a way to see a buffer, there might be multiple windows looking at one buffer
- A tab == a collection of windows

## Special key notation
special keys have a short notation in vim, goes as follows:

| Notation         | Key                                                           |
|------------------|---------------------------------------------------------------|
| `<BS>`           | Backspace                                                     |
| `<Tab>`          | Tab                                                           |
| `<C>`            | Control / Command                                             |
| `<A>`            | Alt / Option                                                  |
| `<leader>`       | Up to the user - NoobVim's default is `space`                 |
| `<CR>`           | Enter                                                         |
| `<Enter>`        | Enter                                                         |
| `<Return>`       | Enter                                                         |
| `<Esc>`          | Escape                                                        |
| `<Space>`        | Space                                                         |
| `<Up>`           | Up arrow                                                      |
| `<Down>`         | Down arrow                                                    |
| `<Left>`         | Left arrow                                                    |
| `<Right>`        | Right arrow                                                   |
| `<F1>` - `<F12>` | Function keys 1 to 12                                         |
| `<Insert>`       | Insert                                                        |
| `<Del>`          | Delete                                                        |
| `<Home>`         | Home                                                          |
| `<End>`          | End                                                           |
| `<PageUp>`       | Page-Up                                                       |
| `<PageDown>`     | Page-Down                                                     |
| `<bar>`          | the `\|` character, which otherwise needs to be escaped `\\|` |

## Keybindings (shortcuts)

Each mode has a list of bindings. The bindings are just combinations of keys that'll result in an action. E.g. out of the box, pressing `k` while in NORMAL mode (n) moves the cursor up one line.
There is nothing stopping you from binding the key `k` to do something else.
To see all your bindings currently set up, while in NORMAL mode, type `:map` and press enter. You'll see a lot of lines looking like this:

```text
n  gcc         * <Lua function 76>
                 Comment toggle current line
```
which can be read like this:
| mode prefix | key combination | action                                          |
|-------------|-----------------|-------------------------------------------------|
| n           | gcc             | * <Lua function 76> Comment toggle current line |

or in other words: pressing `gcc` while in NORMAL mode, will result in calling a function that'll invoke the toggle current line functionality of the Comment plugin

### Keybinding scopes

Keybindings have scopes. You can have global keybindings that'll be available for a particular mode in any buffer, or you can scope them to particular buffers.
This is very handy, as you might want to have specific options only in certain scenarios. E.g it'd probably make sense to only have the shortcut to open / go to a file, when you're in a file viewer of sorts, rather than in every buffer.

### Example of scoped keybindings

Globaly scoped keybindings

![global](./docs/images/keybindings/global.PNG)

Locally scoped keybindings - to the 'DiffviewFilePanel' buffer

![scoped](./docs/images/keybindings/scoped.PNG)

Notice that the globally scoped keybindings are present in the buffer scoped ones.

### Which-key

NoobVim uses [which-key plugin](https://github.com/folke/which-key.nvim) to keep track of which keybindings are available in any given buffer.

</details>

# 🚀 Getting started
To get up and running, 

if you're on Ubuntu/Debian, you can run the install script (you'll need su privileges)

```bash 
TMP_DIR="$HOME/$(date +%s)-noobvim-install" && mkdir -p "$TMP_DIR" && pushd "$TMP_DIR"  && \
git clone -n --depth=1 --filter=tree:0 https://github.com/adrian-soomro/NoobVim && \
cd NoobVim && git sparse-checkout set --no-cone scripts && git checkout && \ 
HASH=$(find ./scripts/* -type f -exec md5sum {} + | md5sum | cut -d " " -f1) && \
if [[ "$HASH" =~ "fc631c413572140a044ac318f4318a92" ]]; then bash ./scripts/installer.sh; else echo "The scripts directory has been tampered with, not runnning anything."; fi && \
popd && rm -rf "$TMP_DIR"
```

if not, you'll need to do the following
1) clone this repo to your `~/.config/` directory,
2) rename it to `nvim` so that the contents of this repo are under `~/.config/nvim/` directory
3) and get the following:

    ## Binaries
    - [neovim 0.8+](https://github.com/neovim/neovim/releases/nightly) - nvim itself
    - [packer](https://github.com/wbthomason/packer.nvim#quickstart) - a plugin manager
    - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) for telescope
    - [glow](https://github.com/charmbracelet/glow#installation) for glow plugin
    - [fd](https://github.com/sharkdp/fd#installation) for telescope-repos
    - [git version 2.31.0+]()

    **NB** you'll also need [make](https://www.gnu.org/software/make/), [cmake](https://cmake.org/install/) and [gcc](https://gcc.gnu.org/install/) 
    once done, update (install) all plugins, using the PackerSync command.

    while in NORMAL MODE, type

    ```
    :PackerSync
    ```

## Make sure your terminal emulator sends the right signals to the terminal

Certain keybindings rely on pressing CTRL + SHIFT + key E.g. CTRL+SHIFT+f. Unfortunately, by default this is not supported in vim/neovim. To make it work, we'll need to tell our terminal emulator to intercept this combination of key presses and send input that can be understood by neovim to the terminal. The way to do it and what input you should send varies based on your terminal emulator.

NoobVim uses these extra bindings, please make sure they work.

| Key Combination |
|-----------------|
| Ctrl-Shift-f    |
| Ctrl-Shift-v    |
| Ctrl-Shift-w    |
| Ctrl-.          |
| Ctrl-,          |

### Window's Terminal:

add this snippet to your [settings.json file](./docs/images/windows_terminal_settings.PNG) to register all the combinations above.
```JSON
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[87;5u"
            },
            "keys": "ctrl+shift+w"
        },
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[86;5u"
            },
            "keys": "ctrl+shift+v"
        },
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[70;5u"
            },
            "keys": "ctrl+shift+f"
        },
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[46;5u"
            },
            "keys": "ctrl+period"
        },
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[44;5u"
            },
            "keys": "ctrl+comma"
        }
```
To add any other characters, have a look at this [list](https://en.wikipedia.org/wiki/List_of_Unicode_characters)

More about escaping characters can be found [here](https://github.com/microsoft/terminal/issues/406) and more about how the input is formulated [here](https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/)

### Alacritty / Kitty
You can use this configuration file to enable CTRL+KEY bindings that NoobVim relies on. You can also use [this guide](https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/) to configure it to your liking. 

```toml
[font]
normal = { family= "FiraCode Nerd Font Mono", style= "Regular" }
size = 12

[keyboard]
bindings = [
    { key= "F",  mods= "Control|Shift", action= "ReceiveChar"},
    { key= "W",  mods= "Control|Shift", action= "ReceiveChar"},
    { key= "V",  mods= "Control|Shift", action= "ReceiveChar"},
    { key= "v",  mods= "Control", action="Paste"},
    { key= ".",  mods= "Control", action= "ReceiveChar"},
    { key= ",",  mods= "Control", action= "ReceiveChar"}
]
```

# Using code runner
You can run your project in a single keypress, similar to other popular IDEs. To do so, you'll first need to tell [code_runner](https://github.com/CRAG666/code_runner.nvim#add-projects) how to run your project.

*NB* you'll need to be in the project's directory for this to work as expected.

# File Skeleton (template) support
If you wish to pre-populate a file with some content every time you create it, simply add a new `{file_extension}.skeleton` file that has your template to the [skeletons](./lua/file-skeleton-config/skeletons) directory. The contents of this skeleton file will be automatically inserted into any new file with that extension.

## ❓ Miscelaneous
- Some of the plugins rely on a Nerd font, [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) will have a nice one. 

### WSL2 Specific
- With regards to the [font requirement](#Miscelaneous) - the fonts need to be installed on the host machine, and set for WSL2 directly in the properties of the WSL2 app.
- Installing [VcXsrv](https://youtu.be/_MgrjgQqDcE?t=755) is highly recommended - this will allow you to share os clipboard between WSL2 host and the WSL2 instance, so that it can be used in nvim, just note that you'll also need to set up `DISPLAY` env var in your bash/zsh.rc 
`export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"`
and [pass `-ac` as additional argument to VcXsrv](https://github.com/microsoft/WSL/issues/4106#issuecomment-502345378)
- Accessing your WSL2 instance through the windows [Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) app is recommended, as this terminal emulator supports italics and other styles of text, while having richer support for nerd-fonts

# Maintenance 
Any docs around how to maintain this can be found [here](./docs/maintenance.md)  

# TODO
- add table of plugins

