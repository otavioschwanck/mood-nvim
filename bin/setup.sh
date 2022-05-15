#!/bin/bash

USER_CONFIG=~/.config/nvim/user.vim
if test -f "$USER_CONFIG"; then
  echo "$USER_CONFIG exists. Ignoring..."
else
  cp ~/.config/nvim/user.example.vim ~/.config/nvim/user.vim
  echo "$USER_CONFIG created."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  echo "$TMUX exists. Ignoring..."
else
  cp ~/.config/nvim/.tmux.conf ~/.tmux.conf
  echo "$TMUX created."
fi

PLUGINS=~/.config/nvim/lua/user-plugins.lua
if test -f "$PLUGINS"; then
  echo "$PLUGINS exists. Ignoring..."
else
  cp ~/.config/nvim/lua/user-plugins.example.lua ~/.config/nvim/lua/user-plugins.lua
  echo "$PLUGINS created."
fi
