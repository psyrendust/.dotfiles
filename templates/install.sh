#!/usr/bin/env zsh
#
# config
#
# This symlinks config and dotfiles to the $HOME directory

ppinfo 'Install config files'

setopt EXTENDED_GLOB
local config_path=${HOME}/.dotfiles/templates

for file in ${config_path}/^(*.sh|*.md)(.N); do
  ln -sf "$file" "${HOME}/.${file:t}"
done

ppok ' - config install complete'
exit 0
