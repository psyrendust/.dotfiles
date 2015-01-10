#!/usr/bin/env bash
#
# Setup
#
# This installs homebrew, oh-my-zsh, and config files.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# Setup ZSH_CUSTOM var
if [ ! -n "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM=~/.dotfiles
fi

export PATH="$ZSH_CUSTOM/plugins/pretty-print/bin:$PATH"

ppinfo "Installing dependencies"

for script in $ZSH_CUSTOM/setup/{homebrew,ohmyzsh,rvm,templates,nvm}/install.sh; do
  "$script" 2>&1
done
