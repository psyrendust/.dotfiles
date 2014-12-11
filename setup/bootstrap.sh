#!/usr/bin/env bash
#
# Setup
#
# This installs homebrew, oh-my-zsh, and config files.

# Check for oh-my-zsh
if [ ! -n "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM=~/.dotfiles
fi

export PATH="$ZSH_CUSTOM/plugins/pretty-print/bin:$PATH"

ppinfo 'installing dependencies'

for script in $ZSH_CUSTOM/{homebrew,ohmyzsh,templates}/install.sh; do
  "$script" 2>&1
done
