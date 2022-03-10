# Dependencies
- Neovim 0.5+
- lazygit
- ripgrep
- etags (Optional)
- NerdFonts

# Installation

## For all operational systems:

- Install a nerd font and configure your terminal to use it.  Nerd fonts here: https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Medium/complete/JetBrains%20Mono%20Medium%20Nerd%20Font%20Complete.ttf

- Install the config

```sh
git clone git@github.com:otavioschwanck/neovim-on-reails.git ~/.config/nvim
```

- Install packer

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

- Install some dependencies:

```sh
pip install neovim-remote neovim
```

## Ubuntu Steps

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
```

## Mac Steps

```sh
brew install lazygit
brew install --HEAD neovim
```

## Add to your .zshrc ou .bashrc:

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

## Run

Run the first time with nvim and execute the command: :PackerSync

# After install

- Check if is missing something with :checkhealth
