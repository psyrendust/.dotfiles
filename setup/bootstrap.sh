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
if [ ! -n "$ZDOT" ]; then
  ZDOT=~/.dotfiles
fi

newpaths=(
  "/usr/local/bin"
  "/usr/local/opt/go/libexec/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
  "$ZDOT/bin"
  "$ZDOT/plugins/npmlist/bin"
  "$ZDOT/plugins/sublime/bin"
  "$ZDOT/plugins/pretty-print/bin"
  "$ZDOT/plugins/safe-rm/bin"
  "$ZDOT/plugins/asciinema2gif/bin"
)
for newpath in ${newpaths[@]}; do
  export PATH="$newpath:$PATH"
done

ppinfo "Installing dependencies"

for script in $ZDOT/setup/{homebrew,ohmyzsh,rvm,nvm,symlinks}/install.sh; do
  "$script" 2>&1
done

$ZDOT/templates/install.sh 2>&1
