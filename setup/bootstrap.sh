#!/bin/sh
#
# Setup
#
# This installs homebrew, oh-my-zsh, and config files.

# Check for oh-my-zsh
if [ ! -n "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM=~/.dotfiles
fi

for script in $ZSH_CUSTOM/{homebrew,ohmyzsh,config}/install.sh; do
  "$script" 2>&1
done
