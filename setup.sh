#!/bin/bash

USER_CONFIG=~/.config/nvim/user.vim
if test -f "$USER_CONFIG"; then
  echo "$USER_CONFIG exists. Ignoring..."
else
  cp ~/.config/nvim/user.example.vim ~/.config/nvim/user.vim
  echo "$USER_CONFIG created."
fi

COC_SETTINGS=~/.config/nvim/coc-settings.json
if test -f "$COC_SETTINGS"; then
  echo "$COC_SETTINGS exists. Ignoring..."
else
  cp ~/.config/nvim/coc-settings.example.json ~/.config/nvim/coc-settings.json
  echo "$COC_SETTINGS created."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  echo "$TMUX exists. Ignoring..."
else
  cp ~/.config/nvim/.tmux.conf ~/.tmux.conf
  echo "$TMUX created."
fi
