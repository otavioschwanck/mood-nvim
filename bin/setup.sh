#!/bin/bash

mkdir -p ~/.config/nvim/lua/user/

USER_CONFIG=~/.config/nvim/lua/user/config.lua
if test -f "$USER_CONFIG"; then
  echo "$USER_CONFIG exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/config.lua ~/.config/nvim/lua/user/config.lua
  echo "$USER_CONFIG created."
fi

VS_SNIPPETS=~/.config/nvim/vs-snippets
if test -d "$VS_SNIPPETS"; then
  echo "$VS_SNIPPETS exists. Ignoring..."
else
  cp -r ~/.config/nvim/extra/examples/vs-snippets/ ~/.config/nvim/vs-snippets
  echo "$VS_SNIPPETS created."
fi

AFTER_CONFIG=~/.config/nvim/lua/user/after_start.lua
if test -f "$AFTER_CONFIG"; then
  echo "$AFTER_CONFIG exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/after_start.lua ~/.config/nvim/lua/user/after_start.lua
  echo "$AFTER_CONFIG created."
fi

USER_KEYBINDINGS=~/.config/nvim/lua/user/keybindings.lua
if test -f "$USER_KEYBINDINGS"; then
  echo "$USER_KEYBINDINGS exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/keybindings.lua ~/.config/nvim/lua/user/keybindings.lua
  echo "$USER_KEYBINDINGS created."
fi

USER_LSP=~/.config/nvim/lua/user/lsp.lua
if test -f "$USER_LSP"; then
  echo "$USER_LSP exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/lsp.lua ~/.config/nvim/lua/user/lsp.lua
  echo "$USER_LSP created."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  echo "$TMUX exists. Ignoring..."
else
  cp ~/.config/nvim/extra/.tmux.conf ~/.tmux.conf
  echo "$TMUX created."
fi

ALACRITTY=~/.config/alacritty/alacritty.yml
if test -f "$ALACRITTY"; then
  echo "$ALACRITTY exists. Ignoring..."
else
  mkdir ~/.config/alacritty
  cp ~/.config/nvim/extra/alacritty.yml ~/.config/alacritty/alacritty.yml

  echo "$ALACRITTY created."
fi

PLUGINS=~/.config/nvim/lua/user/plugins.lua
if test -f "$PLUGINS"; then
  echo "$PLUGINS exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/plugins.lua ~/.config/nvim/lua/user/plugins.lua
  echo "$PLUGINS created."
fi

get_machine_type () {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
  esac
  echo "Proceeding instalation for OS ${machine}"
}

linux_workflow () {
  LAZYGIT=~/.config/lazygit/config.yml
  if test -f "$LAZYGIT"; then
    echo "$LAZYGIT exists. Ignoring..."
  else
    cp ~/.config/nvim/extra/examples/lazygit.yml ~/.config/lazygit/config.yml
    echo "$LAZYGIT created."
  fi
}

mac_workflow () {
  LAZYGIT=~/Library/Application\ Support/lazygit/config.yml
  if test -f "$LAZYGIT"; then
    echo "$LAZYGIT exists. Ignoring..."
  else
    cp ~/.config/nvim/extra/examples/lazygit.yml ~/Library/Application\ Support/lazygit/config.yml
    echo "$LAZYGIT created."
  fi
}

get_machine_type

case "${machine}" in
  Linux)     linux_workflow;;
  Mac)       mac_workflow;;
  *)         echo "OS not recognized"
esac

