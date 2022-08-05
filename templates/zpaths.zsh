#!/usr/bin/env zsh
#
# Define path locations.
#
# Authors:
#   Larry Gordon
#
# Usage: loaded by $ZDOT_TEMPLATES/zshrc.zsh
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/templates/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Setup paths
# ------------------------------------------------------------------------------
typeset -a __path_pre __path_post __manpath_pre __manpath_post


# Custom path locations for my plugins
__path_pre+=("$ZDOT_PLUGINS/asciinema2gif/bin")
__path_pre+=("$ZDOT_PLUGINS/pretty-print/bin")
__path_pre+=("$ZDOT_PLUGINS/npmlist/bin")
__path_pre+=("$ZDOT_PLUGINS/textcleaner/bin")
__path_pre+=("$ZDOT_PLUGINS/iterm2/bin")
__path_pre+=("$ZDOT_PLUGINS/vscode/bin")
__path_pre+=("$ZDOT_DROPBOX_BIN")
__path_pre+=("$ZDOT_BIN")
__path_pre+=("$HOME/.tmpbin")


# Add GOPATH and GOROOT
[[ -d "$GOPATH" ]] && [[ -d "$GOPATH/bin" ]] && __path_pre+=("$GOPATH/bin")
[[ -d "$GOROOT" ]] && [[ -d "$GOROOT/bin" ]] && __path_pre+=("$GOROOT/bin")

# Add homebrews bin
[[ -z $(echo $PATH | grep "$ZDOT_BREW_ROOT/bin") ]] && __path_pre+=("$ZDOT_BREW_ROOT/bin")

# Add manpath
__manpath_pre+=("$ZDOT_BREW_ROOT/share/man")


# ------------------------------------------------------------------------------
# Apply PATHS
# ------------------------------------------------------------------------------
export MANPATH="$([[ ${#__manpath_pre} > 0 ]] && printf "%s:" "${__manpath_pre[@]}")$MANPATH$([[ ${#__manpath_post} > 0 ]] && printf ":%s" "${__manpath_post[@]}")"
export PATH="$([[ ${#__path_pre} > 0 ]] && printf "%s:" "${__path_pre[@]}")$PATH$([[ ${#__path_post} > 0 ]] && printf ":%s" "${__path_post[@]}")"

unset __path_pre
unset __path_post
unset __manpath_pre
unset __manpath_post


# ------------------------------------------------------------------------------
# Load any private environment variables
# ------------------------------------------------------------------------------
zdot load "$ZDOT_DROPBOX_APPS/index.zsh"
