#!/bin/bash

mkdir -p ~/.config/nvim/lua/user/

DEBUGGER=~/.config/nvim/lua/user/debugger.lua
if test -f "$DEBUGGER"; then
  echo "$DEBUGGER exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/debugger.lua ~/.config/nvim/lua/user/debugger.lua
  echo "$DEBUGGER created."
fi

USER_CONFIG=~/.config/nvim/lua/user/config.lua
if test -f "$USER_CONFIG"; then
  echo "$USER_CONFIG exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/config.lua ~/.config/nvim/lua/user/config.lua
  echo "$USER_CONFIG created."
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

