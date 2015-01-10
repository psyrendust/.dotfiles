#!/usr/bin/env bash
#
# oh-my-zsh
#
# This installs oh-my-zsh.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

ppinfo "Install oh-my-zsh"

ppinfo " - Check for oh-my-zsh"
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi

if [ ! -d "$ZSH" ]; then
  ppinfo " - Installing oh-my-zsh"
  curl -L http://install.ohmyz.sh | sh
  rm ~/.zshrc
fi

ppok " - oh-my-zsh install complete"
exit 0
