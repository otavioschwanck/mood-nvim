# Introduction

mooD Nvim is a configuration made for those who wants to install and use, without much worries.

# Features

- 100% on Lua
- Extra snippets
- Handbook (SPC h h) and Tutorial (SPC h T) natively.  Most of cool feature are listed there.
- Test Runner
- Fully customizable by user (plugins, settings, LSP)
- Find In Folder helpers: Find inside models, controller, etc using keybindngs. See `config.lua` (`SPC f p`) for more examples. You can define your own custom finders.
- TMUX Framework with `tmux-awesome-manager` that can:
  - You can bind terminal commands in your `config.lua` (`SPC f p`).
  - Useful for commands such as rails console, server, sidekiq, yarn start, generate, etc. (Examples on `config.lua`)
  - You can define server terminal commands for each project and run with a single command.

# Demo

![demo](extra/demo.gif)

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

# Manual Installation

1. Install a nerd font and configure your terminal to use it. Nerd fonts [Here](https://www.nerdfonts.com/font-downloads)
2. Install the config

```sh
git clone git@github.com:otavioschwanck/mood-nvim.git ~/.config/nvim
```

3. Run this: `git config --global push.default current`
4. Install packer:

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

5. Install some dependencies:

```sh
npm install -g neovim diagnostic-languageserver
gem install solargraph neovim
```

6. (a) Ubuntu Steps

```sh
sudo apt install python3-pip
python3 -m pip install neovim-remote pynvim

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update

sudo apt-get install sqlite3 libsqlite3-dev neovim xclip

bash
export VER="0.34" # you can search for a more recent one
wget -O lazygit.tgz https://github.com/jesseduffield/lazygit/releases/download/v${VER}/lazygit_${VER}_Linux_x86_64.tar.gz
tar xvf lazygit.tgz
sudo mv lazygit /usr/local/bin/
```

6. (b) Mac Steps

```sh
brew install jesseduffield/lazygit/lazygit
brew install lazygit sqlite
brew install --HEAD neovim

python -m pip install neovim-remote pynvim # Can be python3 too, maybe you need to install pip
```

7. Add to your .zshrc ou .bashrc:

```sh
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi
```

8. Run `nvim` on the terminal and then, run `:PackerSync`.

# After install

- Check the `user.vim` for let `g:python_host_prog` part. Probabily you will need to comment or change (if on mac ou using pyenv).
- Check if is missing something with `:checkhealth`

# For mac Users

To use Alt commands, like M-d (multiple-cursors), use Option + key.

# Updating

Run `:UpdateMood`.

# How to learn the keybindings of this configuration?

Just press `SPC h h` to open the handbook inside vim.

# Other tips

## Tmux

I Really recommend you to learn tmux / tmuxinator. Take a look on tmuxinator on youtube.

To install the tpm (Tmux package manager), run:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

This config creates a tmux config for you (if doesn't exists). To install the onedark theme, just press `C-x I` inside tmux
