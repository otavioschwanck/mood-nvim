#!/bin/bash

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

PLUGINS=~/.config/nvim/lua/user/plugins.lua
if test -f "$PLUGINS"; then
  echo "$PLUGINS exists. Ignoring..."
else
  cp ~/.config/nvim/extra/examples/plugins.lua ~/.config/nvim/lua/user/plugins.lua
  echo "$PLUGINS created."
fi
