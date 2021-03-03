#!/usr/bin/env zsh
#
# Define environment variables for login, non-login, interactive and
# non-interactive shells.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshenv
#   #!/usr/bin/env zsh
#   [[ -f "$HOME/.dotfiles/templates/zshenv.zsh" ]] && source "$HOME/.dotfiles/templates/zshenv.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/templates/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


export VISUAL='/usr/local/bin/code --wait'
export EDITOR="$VISUAL"
export FZF_PATH="/usr/local/opt/fzf"
export ZSH_CUSTOM="$HOME/.dotfiles"

export ZDOT="$HOME/.dotfiles"
export ZDOT_BIN="$ZDOT/bin"
export ZDOT_CACHE="$ZDOT/cache"
export ZDOT_FUNCTIONS="$ZDOT/functions"
export ZDOT_LIB="$ZDOT/lib"
export ZDOT_PLUGINS="$ZDOT/plugins"
export ZDOT_TEMPLATES="$ZDOT/templates"
export ZDOT_THEME="$ZDOT/theme"
export ZDOT_DROPBOX_APPS="$HOME/Dropbox/Larry/Apps"

[[ -d "$HOME/.go" ]] && export GOPATH="$HOME/.go"
[[ -d "/usr/local/opt/go/libexec" ]] && export GOROOT="/usr/local/opt/go/libexec"
# export JAVA_VERSION=1.7
# export JAVA_HOME="$(/usr/libexec/java_home)"


# ------------------------------------------------------------------------------
# Setup options
# ------------------------------------------------------------------------------
setopt EXTENDED_GLOB


# ------------------------------------------------------------------------------
# Add a function path & load them
# ------------------------------------------------------------------------------
fpath=(
  "$ZDOT_FUNCTIONS"(N-/)
  "$ZDOT_FUNCTIONS"/*(N-/)
  "$fpath[@]"
)
autoload -Uz compinit
autoload -Uz zdot

compinit
