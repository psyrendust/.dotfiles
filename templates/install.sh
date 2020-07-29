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

ppok " - config install complete"
exit 0
