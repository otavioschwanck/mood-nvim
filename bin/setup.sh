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

USER_COC=~/.config/nvim/coc-settings.json
if test -f "$USER_COC"; then
  echo "$USER_COC exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/coc-settings.example.json ~/.config/nvim/coc-settings.json
  echo "$USER_COC created."
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
