#!/bin/bash

USER_CONFIG=~/.config/nvim/user.vim
if test -f "$USER_CONFIG"; then
  rm $USER_CONFIG
  echo "$USER_CONFIG Remove successfully..."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  rm $TMUX
  echo "$TMUX Removed successfully..."
fi

PLUGINS=~/.config/nvim/lua/user-plugins.lua
if test -f "$PLUGINS"; then
  rm $PLUGINS
  echo "$PLUGINS Removed successfully..."
fi
