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

newpaths=(
  "/usr/local/bin"
  "/usr/local/opt/go/libexec/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
  "$ZSH_CUSTOM/bin"
  "$ZSH_CUSTOM/plugins/npmlist/bin"
  "$ZSH_CUSTOM/plugins/sublime/bin"
  "$ZSH_CUSTOM/plugins/pretty-print/bin"
  "$ZSH_CUSTOM/plugins/safe-rm/bin"
  "$ZSH_CUSTOM/plugins/asciinema2gif/bin"
)
for newpath in ${newpaths[@]}; do
  export PATH="$newpath:$PATH"
done

ppinfo "Installing dependencies"

for script in $ZSH_CUSTOM/setup/{homebrew,ohmyzsh,rvm,nvm,symlinks}/install.sh; do
  "$script" 2>&1
done

$ZSH_CUSTOM/templates/install.sh 2>&1
