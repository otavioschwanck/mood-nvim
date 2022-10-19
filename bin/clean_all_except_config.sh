#!/bin/bash

DEBUGGER=~/.config/nvim/lua/user/debugger.lua
if test -f "$DEBUGGER"; then
  rm $DEBUGGER
  echo "$DEBUGGER Remove successfully..."
fi


USER_LSP=~/.config/nvim/lua/user/lsp.lua
if test -f "$USER_LSP"; then
  rm $USER_LSP
  echo "$USER_LSP Removed successfully..."
fi

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

