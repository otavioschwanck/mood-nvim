#!/bin/bash

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  rm $TMUX
  echo "$TMUX Removed successfully..."
fi

ALACRITTY=~/.config/alacritty/alacritty.yml
if test -f "$ALACRITTY"; then
  rm $ALACRITTY
  echo "$ALACRITTY Removed successfully..."
fi


PLUGINS=~/.config/nvim/lua/user/plugins.lua
if test -f "$PLUGINS"; then
  rm $PLUGINS
  echo "$PLUGINS Removed successfully..."
fi
