#!/bin/sh
#
# oh-my-zsh
#
# This installs oh-my-zsh

# Check for oh-my-zsh
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi

if [ ! -d "$ZSH" ]; then
  echo "  Installing oh-my-zsh for you."
  curl -L http://install.ohmyz.sh | sh
fi

exit 0
