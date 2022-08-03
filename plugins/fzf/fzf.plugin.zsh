#!/usr/bin/env zsh
#
# Custom fzf config
#
# @see https://github.com/junegunn/fzf#settings
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# Use ** as the trigger sequence instead: default **
export FZF_COMPLETION_TRIGGER='**'

# Default command to use when input is tty
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'


# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# Usage:
#     `vim **<tab>`
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
# Usage:
#     `cd **<tab>`
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Setup fzf
# ---------
if [[ ! "$PATH" == *$ZDOT_BREW_ROOT/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
zdot load "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
zdot load "$FZF_PATH/shell/key-bindings.zsh"
