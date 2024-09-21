#!/bin/bash

CONFIG_DIR=$(dirname "$MYVIMRC")

USER_CONFIG="$CONFIG_DIR/lua/user/config.lua"
if test -f "$USER_CONFIG"; then
  rm "$USER_CONFIG"
  echo "$USER_CONFIG removed successfully..."
fi

BEFORE_START="$CONFIG_DIR/lua/user/before_start.lua"
if test -f "$BEFORE_START"; then
  rm "$BEFORE_START"
  echo "$BEFORE_START removed successfully..."
fi

AFTER_CONFIG="$CONFIG_DIR/lua/user/after_start.lua"
if test -f "$AFTER_CONFIG"; then
  rm "$AFTER_CONFIG"
  echo "$AFTER_CONFIG removed successfully..."
fi

KEYBINDINGS="$CONFIG_DIR/lua/user/keybindings.lua"
if test -f "$KEYBINDINGS"; then
  rm "$KEYBINDINGS"
  echo "$KEYBINDINGS removed successfully..."
fi

USER_LSP="$CONFIG_DIR/lua/user/lsp.lua"
if test -f "$USER_LSP"; then
  rm "$USER_LSP"
  echo "$USER_LSP removed successfully..."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  rm "$TMUX"
  echo "$TMUX removed successfully..."
fi

ALACRITTY=~/.config/alacritty/alacritty.yml
if test -f "$ALACRITTY"; then
  rm "$ALACRITTY"
  echo "$ALACRITTY removed successfully..."
fi

PLUGINS="$CONFIG_DIR/lua/user/plugins.lua"
if test -f "$PLUGINS"; then
  rm "$PLUGINS"
  echo "$PLUGINS removed successfully..."
fi
