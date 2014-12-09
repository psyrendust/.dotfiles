#!/usr/bin/env zsh

function run() {
  setopt EXTENDED_GLOB
  local config_path=${HOME}/.dotfiles/config

  for file in ${config_path}/^install.sh(.N); do
    ln -s "$file" "${HOME}/.${file:t}"
  done
}
run
