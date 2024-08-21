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


# ------------------------------------------------------------------------------
# Initialize fzf path
export FZF_PATH="$ZDOT_BREW_ROOT/opt/fzf"
export FZF_BIN="$FZF_PATH/bin"

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
if [[ ! "$PATH" == *$FZF_BIN* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_BIN}"
fi

# ------------------------------------------------------------------------------
# Auto-completion
zdot load "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# ------------------------------------------------------------------------------
# Key bindings
zdot load "$FZF_PATH/shell/key-bindings.zsh"


# ------------------------------------------------------------------------------
# Customize fzf theme
# https://vitormv.github.io/fzf-themes#eyJib3JkZXJTdHlsZSI6InJvdW5kZWQiLCJib3JkZXJMYWJlbCI6IiIsImJvcmRlckxhYmVsUG9zaXRpb24iOjAsInByZXZpZXdCb3JkZXJTdHlsZSI6ImJvbGQiLCJwYWRkaW5nIjoiMCIsIm1hcmdpbiI6IjAiLCJwcm9tcHQiOiLina8gIiwibWFya2VyIjoi4p2vICIsInBvaW50ZXIiOiLilowiLCJzZXBhcmF0b3IiOiLilIAiLCJzY3JvbGxiYXIiOiLilIIiLCJsYXlvdXQiOiJkZWZhdWx0IiwiaW5mbyI6ImRlZmF1bHQiLCJjb2xvcnMiOiJmZzojYjJjMGRiLGZnKzojZWJlZGU0LGJnKzojMjYyNjI2LGhsOiM1ZmZmODcsaGwrOiM1ZmQ3ZmYsaW5mbzojNzNkMGZmLG1hcmtlcjojNWZmZjg3LHByb21wdDojZDcwMDVmLHNwaW5uZXI6IzczZDBmZixwb2ludGVyOiNhZjVmZmYsaGVhZGVyOiNhZjg3ZmYsYm9yZGVyOiMyNjI2MjYsbGFiZWw6I2FlYWVhZSxxdWVyeTojZDlkOWQ5In0=
#
#
# ------------------------------------------------------------------------------
# Custom color options
# ------------------------------------------------------------------------------
# fg:#b2c0db
# fg+:#ebede4
# bg:-1
# bg+:-1
# hl:#5fff87
# hl+:#5fd7ff
# info:#73d0ff
# marker:#5fff87
# prompt:#d7005f
# spinner:#73d0ff
# pointer:#af5fff
# header:#af87ff
# border:#262626
# label:#aeaeae
# query:#d9d9d9

# ------------------------------------------------------------------------------
# Theme options
# ------------------------------------------------------------------------------
# --border="rounded"
# --border-label=""
# --preview-window="border-bold"
# --prompt="❯ "
# --marker="❯ "
# --pointer="▌"
# --separator="─"
# --scrollbar="│"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#b2c0db,fg+:#ebede4,bg:-1,bg+:-1
  --color=hl:#5fff87,hl+:#5fd7ff,info:#73d0ff,marker:#5fff87
  --color=prompt:#d7005f,spinner:#73d0ff,pointer:#af5fff,header:#af87ff
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-bold" --prompt="❯ "
  --marker="❯ " --pointer="▌" --separator="─" --scrollbar="│"
'

