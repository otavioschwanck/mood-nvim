# Introduction

mooD Nvim is a configuration made for those who wants to install and use, without much worries.

# For who is this configuration?

- For those who lieks to just install and use.
- For those who likes Doom Emacs Defaults.
- For those who likes speed editing.
- For terminal lovers.

# Features

- CoC for LSP (go to definition, autocomplete, etc)
- Extra snippets
- Quick handbook inside vim.  Just press `SPC h h`
- Test Runner
- Fully customizable (plugins, settings, CoC)
- Find In Folder helpers: Find inside models, controller, etc using keybindngs.  See `user.vim` (`SPC f p`) for more examples.  You can define your own custom finders  You can define your own custom finders.
- Mini Terminal Framework that can:
  - You can bind terminal commands in your `user.vim` (`SPC f p`).
  - You can configure if this command is unique or not, if its unique, when press the mapping again, it will focus instead opening a new.
  - Useful for commands such as rails console, server, sidekiq, yarn start, generate, etc. (Examples on `user.vim`)

# Demo

![demo](demo.gif)

# Dependencies
- Neovim > 0.7 && < 0.8
- lazygit
- ripgrep
- NerdFonts
- Python

# Automatic Installation

We created a bash script to make your life easier and install Mood Nvim automatically.
Just run the below command in the terminal on either mac or linux, choose what you want to install and have fun!

```sh
bash <(curl -Ls https://raw.githubusercontent.com/otavioschwanck/mood-nvim/main/mood-installer.sh)
```
# Manual Installation

1. Install a nerd font and configure your terminal to use it.  Nerd fonts [Here](https://www.nerdfonts.com/font-downloads)
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

- Check the `user.vim` for let `g:python_host_prog` part.  Probabily you will need to comment or change (if on mac ou using pyenv).
- Check if is missing something with `:checkhealth`

# For mac Users

To use Alt commands, like M-d (multiple-cursors), use Option + key.

# Updating

Run `:UpdateMood`.

# How to learn the keybindings of this configuration?

Just press `SPC h h` to open the handbook inside vim.

# Troubleshoot

## Error on python for some reason.

Check your personal config `SPC f p` at the bottom.  Set the python envs to their real values.

## Solargraph asks to install ruby

1. On your user.vim `(SPC f p)`, remove coc-solargraph
2. Close and reopen vim
3. Run :CocUninstall coc-solargraph
4. On your coc-settings.json `(SPC h c)`, add on inside languageserver key:

```json
  "languageserver": {
    "solargraph": {
        "command": "solargraph",
        "args": ["stdio"],
        "trace.server": "verbose",
        "rootPatterns": [".git/"],
        "filetypes": ["ruby"]
    },
    ...
  }
```

# Other tips

## Tmux

I Really recommend you to learn tmux / tmuxinator.  Take a look on tmuxinator on youtube.
