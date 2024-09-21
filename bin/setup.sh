#!/bin/bash

CONFIG_DIR=$(dirname "$MYVIMRC")

mkdir -p "$CONFIG_DIR/lua/user/"

USER_CONFIG="$CONFIG_DIR/lua/user/config.lua"
if test -f "$USER_CONFIG"; then
  echo "$USER_CONFIG exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/config.lua" "$USER_CONFIG"
  echo "$USER_CONFIG created."
fi

BEFORE_START="$CONFIG_DIR/lua/user/before_start.lua"
if test -f "$BEFORE_START"; then
  echo "$BEFORE_START exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/before_start.lua" "$BEFORE_START"
  echo "$BEFORE_START created."
fi

VS_SNIPPETS="$CONFIG_DIR/vs-snippets"
if test -d "$VS_SNIPPETS"; then
  echo "$VS_SNIPPETS exists. Ignoring..."
else
  cp -r "$CONFIG_DIR/extra/examples/vs-snippets/" "$VS_SNIPPETS"
  echo "$VS_SNIPPETS created."
fi

AFTER_CONFIG="$CONFIG_DIR/lua/user/after_start.lua"
if test -f "$AFTER_CONFIG"; then
  echo "$AFTER_CONFIG exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/after_start.lua" "$AFTER_CONFIG"
  echo "$AFTER_CONFIG created."
fi

USER_KEYBINDINGS="$CONFIG_DIR/lua/user/keybindings.lua"
if test -f "$USER_KEYBINDINGS"; then
  echo "$USER_KEYBINDINGS exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/keybindings.lua" "$USER_KEYBINDINGS"
  echo "$USER_KEYBINDINGS created."
fi

USER_LSP="$CONFIG_DIR/lua/user/lsp.lua"
if test -f "$USER_LSP"; then
  echo "$USER_LSP exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/lsp.lua" "$USER_LSP"
  echo "$USER_LSP created."
fi

TMUX=~/.tmux.conf
if test -f "$TMUX"; then
  echo "$TMUX exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/.tmux.conf" "$TMUX"
  echo "$TMUX created."
fi

ALACRITTY=~/.config/alacritty/alacritty.yml
if test -f "$ALACRITTY"; then
  echo "$ALACRITTY exists. Ignoring..."
else
  mkdir -p ~/.config/alacritty
  cp "$CONFIG_DIR/extra/alacritty.yml" "$ALACRITTY"
  echo "$ALACRITTY created."
fi

PLUGINS="$CONFIG_DIR/lua/user/plugins.lua"
if test -f "$PLUGINS"; then
  echo "$PLUGINS exists. Ignoring..."
else
  cp "$CONFIG_DIR/extra/examples/plugins.lua" "$PLUGINS"
  echo "$PLUGINS created."
fi

TEMPLATES="$CONFIG_DIR/lua/templates/ruby.lua"
if test -f "$TEMPLATES"; then
  echo "$TEMPLATES exists. Ignoring..."
else
  cp -r "$CONFIG_DIR/extra/examples/templates/" "$CONFIG_DIR/lua/templates/"
  echo "$TEMPLATES created."
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
    cp "$CONFIG_DIR/extra/examples/lazygit.yml" ~/.config/lazygit/config.yml
    echo "$LAZYGIT created."
  fi
}

mac_workflow () {
  LAZYGIT=~/Library/Application\ Support/lazygit/config.yml
  if test -f "$LAZYGIT"; then
    echo "$LAZYGIT exists. Ignoring..."
  else
    cp "$CONFIG_DIR/extra/examples/lazygit.yml" ~/Library/Application\ Support/lazygit/config.yml
    echo "$LAZYGIT created."
  fi
}

get_machine_type

case "${machine}" in
  Linux)     linux_workflow;;
  Mac)       mac_workflow;;
  *)         echo "OS not recognized"
esac
