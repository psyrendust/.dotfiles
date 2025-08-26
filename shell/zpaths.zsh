#!/usr/bin/env zsh
#
# Define path locations.
#
# Authors:
#   Larry Gordon
#
# Usage: loaded by $ZDOT_SHELL/zprofile.zsh
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Setup paths
# ------------------------------------------------------------------------------
typeset -a __path_pre __path_post


# Custom path locations for my plugins
__path_pre+=("$ZDOT_PLUGINS/asciinema2gif/bin")
__path_pre+=("$ZDOT_PLUGINS/changecase/bin")
__path_pre+=("$ZDOT_PLUGINS/pretty-print/bin")
__path_pre+=("$ZDOT_PLUGINS/npmlist/bin")
__path_pre+=("$ZDOT_PLUGINS/textcleaner/bin")
__path_pre+=("$ZDOT_PLUGINS/iterm2/bin")
__path_pre+=("$ZDOT_PLUGINS/vscode/bin")
__path_pre+=("$ZDOT_DROPBOX_BIN")
__path_pre+=("$ZDOT_BIN")
__path_pre+=("$HOME/.tmpbin")


# Custom path locations for my work plugins
__path_pre+=("$ZDOT_WORK_BIN")


# Add GOPATH and GOROOT
[[ -d "$GOPATH" ]] && [[ -d "$GOPATH/bin" ]] && __path_pre+=("$GOPATH/bin")
[[ -d "$GOROOT" ]] && [[ -d "$GOROOT/bin" ]] && __path_pre+=("$GOROOT/bin")

# Add coreutils bin
[[ -z $(echo $PATH | grep "$ZDOT_BREW_ROOT/opt/coreutils/libexec/gnubin") ]] && __path_pre+=("$ZDOT_BREW_ROOT/opt/coreutils/libexec/gnubin")


# ------------------------------------------------------------------------------
# Add homebrews paths with `brew shellenv`, evals the following
# ------------------------------------------------------------------------------
#   export HOMEBREW_PREFIX="/opt/homebrew";
#   export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
#   export HOMEBREW_REPOSITORY="/opt/homebrew";
#   export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
#   export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
#   export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
# ------------------------------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"


# ------------------------------------------------------------------------------
# Add pyenv path with `pyenv init -`
# @see https://opensource.com/article/19/5/python-3-default-mac#what-we-should-do
# ------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# ------------------------------------------------------------------------------
# Apply PATHS
# ------------------------------------------------------------------------------
export PATH="$([[ ${#__path_pre} > 0 ]] && printf "%s:" "${__path_pre[@]}")$PATH$([[ ${#__path_post} > 0 ]] && printf ":%s" "${__path_post[@]}")"

unset __path_pre
unset __path_post
