#!/usr/bin/env zsh
#
# Template setup.
#
# This symlinks config and dotfiles to the $HOME directory.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

ppinfo "Install config files"

setopt EXTENDED_GLOB
dotfiles_path=${HOME}/.dotfiles
templates_path=${dotfiles_path}/templates

for file in ${templates_path}/^(*.sh|*.md)(.N); do
  ln -sf "$file" "${HOME}/.${file:t}"
done

# Symlink the templates/mackup folder to the $HOME directory
if [[ -s $HOME/Dropbox/Larry/_mackup/.mackup.cfg ]]; then
  ln -sf $HOME/Dropbox/Larry/_mackup/.mackup.cfg $HOME/.mackup.cfg
fi

ppok " - config install complete"
exit 0
