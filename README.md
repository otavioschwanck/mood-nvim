# Introduction

mooD Nvim is a configuration made for those who wants to install and use, without worries.

![image 1](https://i.imgur.com/2H8EqrG.png)
![image 2](https://i.imgur.com/F87jxNP.png)
![image 3](https://i.imgur.com/mn23tWt.png)
![image 4](https://i.imgur.com/pe8HbTJ.png)
![image 5](https://i.imgur.com/ddcsriV.png)

# Features

- 100% on Lua
- IDE Features: LSP, snippets, autocomplete, go to definition, go to references, etc.
- Handbook (SPC h h) and Tutorial (SPC h T) natively.  Most of cool feature are listed there.
- Awesome Test Runner.
- Fully customizable by user (plugins, settings, LSP)
- Find In Folder helpers: Find inside models, controller, etc using keybindngs. See `keybindings.lua` (`SPC f p`) for more examples. You can define your own custom finders.
- TMUX Framework with `tmux-awesome-manager` that can:
  - You can bind terminal commands in your `keybindings.lua` (`SPC f p`).
  - Useful for commands such as rails console, server, sidekiq, yarn start, generate, open production stuff, etc. (Examples on `keybindings.lua`)
  - You can define server terminal commands separated by project and run with a single command.

# Dependencies

- Neovim >= 0.8 <= 0.9
- lazygit
- ripgrep
- NerdFonts
- Python

# Automatic Installation

We created a bash script to make your life easier and install Mood Nvim automatically.
Just run the below command in the terminal on either mac or linux, choose what you want to install and have fun!

```sh
bash <(curl -Ls https://raw.githubusercontent.com/otavioschwanck/mood-nvim/main/bin/mood-installer.sh)
```

If you will use tmux, after the first open, press `C-x I` to install the packages.

To install manually, check the page: https://github.com/otavioschwanck/mood-nvim/wiki/Manual-Installation#manual-installation

# After install

- Check if is missing something with `:checkhealth`

# How to learn the keybindings of this configuration?

Just press `SPC h h` to open the handbook inside vim.

## Tmux + Alacritty

I Really recommend you to learn tmux / tmuxinator. Check the handbook inside the neovim.
