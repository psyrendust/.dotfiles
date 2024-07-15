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


# ------------------------------------------------------------------------------
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# Usage:
#     `vim **<tab>`
# _fzf_compgen_path() {
#   fd --hidden --follow --exclude ".git" . "$1"
# }

# Use fd to generate the list for directory completion
# Usage:
#     `cd **<tab>`
# _fzf_compgen_dir() {
#   fd --type d --hidden --follow --exclude ".git" . "$1"
# }


# ------------------------------------------------------------------------------
# Uses bfs to put shallow-depth paths closer to the top of results, while also
# leveraging bfs' superior performance over fd.
#
# Based on: https://github.com/tavianator/bfs/discussions/119
#
# See also: bfs vs fd vs find benchmark
# https://tavianator.com/2023/bfs_3.0.html#so-how-fast-is-it
# Usage:
#     `vim **<tab>`
_fzf_compgen_path() {
  bfs -H "$1" -color -exclude \( -name .git \) 2>/dev/null
}
# Use bfs to generate the list for directory completion
# Usage:
#     `cd **<tab>`
_fzf_compgen_dir() {
  bfs -H "$1" -color -exclude \( -name .git \) -type d 2>/dev/null
}


# ------------------------------------------------------------------------------
# Add fzf to the PATH
if [[ ! "$PATH" == *$ZDOT_BREW_ROOT/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_PATH}/bin"
fi

# ------------------------------------------------------------------------------
# Auto-completion
zdot load "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# ------------------------------------------------------------------------------
# Key bindings
zdot load "$FZF_PATH/shell/key-bindings.zsh"

# ------------------------------------------------------------------------------
# Default color options
# fg:#8e99ad
# fg+:#ebede4
# hl+:#ff87d7
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#b2c0db,bg:-1,hl:#5fff87
  --color=fg+:#ebede4,bg+:-1,hl+:#5fff87
  --color=info:#73d0ff,prompt:#5fff87,pointer:#ff87d7
  --color=marker:#5fff87,spinner:#73d0ff,header:#af87ff
'
