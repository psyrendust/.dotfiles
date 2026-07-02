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
#   [[ -f "$HOME/.dotfiles/shell/zshenv.zsh" ]] && source "$HOME/.dotfiles/shell/zshenv.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
### Keep PATH unique
# ------------------------------------------------------------------------------
typeset -U path fpath manpath


# ------------------------------------------------------------------------------
### What architecture are we using
# ------------------------------------------------------------------------------
export ZDOT_ARCH=$(uname -m)
if [[ $ZDOT_ARCH == "arm64" ]]; then
  export ZDOT_M1=1
  export ZDOT_BREW_ROOT="/opt/homebrew"
elif [[ $ZDOT_ARCH == "x86_64" ]]; then
  export ZDOT_X86=1
  export ZDOT_BREW_ROOT="/usr/local"
fi

export BAT_PAGER="less -R"
export ZSH_CUSTOM="$HOME/.dotfiles"


# ------------------------------------------------------------------------------
### Zdot paths
# ------------------------------------------------------------------------------
export ZDOT="$HOME/.dotfiles"
export ZDOT_BIN="$ZDOT/bin"
export ZDOT_CACHE="$ZDOT/cache"
export ZDOT_GIT_CONFIG="$ZDOT/gitconfig"
export ZDOT_FUNCTIONS="$ZDOT/functions"
export ZDOT_LIB="$ZDOT/lib"
export ZDOT_PLUGINS="$ZDOT/plugins"
export ZDOT_TEMPLATES="$ZDOT/templates"
export ZDOT_SHELL="$ZDOT/shell"
export ZDOT_THEME="$ZDOT/themes"
export ZDOT_DROPBOX="$HOME/Library/CloudStorage/Dropbox"
export ZDOT_DROPBOX_APPS="$ZDOT_DROPBOX/Apps"
export ZDOT_DROPBOX_BIN="$ZDOT_DROPBOX_APPS/bin"
export ZDOT_ICLOUD_DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"


# ------------------------------------------------------------------------------
### Zdot work paths
# ------------------------------------------------------------------------------
export ZDOT_WORK="$HOME/.dotfileswork"
export ZDOT_WORK_BIN="$ZDOT_WORK/bin"
export ZDOT_WORK_CODE="$HOME/work/code"

# Antidote work bundle (loaded before the main one in zshrc-antidote.zsh)
export ZDOT_WORK_PLUGIN_CONFIG="$ZDOT_WORK/shell/zshrc-antidote-plugins.conf"
export ZDOT_WORK_PLUGIN_CACHE="$ZDOT_WORK/shell/zshrc-antidote-plugins.zsh"


# ------------------------------------------------------------------------------
### Use vscode as the default editor, but use my plugin version
# ------------------------------------------------------------------------------
export VISUAL="$ZDOT_PLUGINS/vscode/bin/code --wait"
export EDITOR="$VISUAL"


# ------------------------------------------------------------------------------
### Add Go vars if they exist
# ------------------------------------------------------------------------------
[[ -d "$HOME/go" ]] && export GOPATH="$HOME/go"
[[ -d "$ZDOT_BREW_ROOT/opt/go/libexec" ]] && export GOROOT="$ZDOT_BREW_ROOT/opt/go/libexec"


# ------------------------------------------------------------------------------
### Add Claude vars if they exist
# ------------------------------------------------------------------------------
[[ -d "$HOME/.claude/bin" ]] && export CLAUDE_BIN="$HOME/.claude/bin"


# ------------------------------------------------------------------------------
### Add Bun vars if they exist
# ------------------------------------------------------------------------------
[[ -d "$HOME/.bun" ]] && export BUN_INSTALL="$HOME/.bun"


# ------------------------------------------------------------------------------
### Add Docker cli completions
# ------------------------------------------------------------------------------
[[ -d "$HOME/.docker/completions" ]] && fpath=($HOME/.docker/completions $fpath)


# ------------------------------------------------------------------------------
### Zsh-z options https://github.com/agkozak/zsh-z?tab=readme-ov-file#settings
# ------------------------------------------------------------------------------
ZSHZ_CASE=ignore


# ------------------------------------------------------------------------------
### Config for sharkdp/bat
# ------------------------------------------------------------------------------
export BAT_THEME="TwoDark"


# ------------------------------------------------------------------------------
### Config for lukechilds/zsh-nvm
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=false
export NVM_NO_USE=false
export NVM_AUTO_USE=false


# ------------------------------------------------------------------------------
### AI / Claude Code / LSP stuff
# ------------------------------------------------------------------------------
export ENABLE_LSP_TOOL=1


# ------------------------------------------------------------------------------
### Setup options
# ------------------------------------------------------------------------------
setopt EXTENDED_GLOB


# ------------------------------------------------------------------------------
### Add Zdot function & completion search paths
#
# These dirs go on $fpath so zsh can autoload our functions (zdot, pkg) and so
# compinit can later discover their completions (_zdot, _pkg). compinit is
# deliberately NOT run here — .zshenv is sourced for every shell (including
# non-interactive scripts); it runs once, for interactive shells only, from
# $ZDOT_SHELL/zshrc.zsh.
# ------------------------------------------------------------------------------
fpath=(
  "$ZDOT_FUNCTIONS"(N-/)
  "$ZDOT_FUNCTIONS"/*(N-/)
  "$HOME/.bun"(N-/)
  "$fpath[@]"
)
autoload -Uz zdot
autoload -Uz pkg

# Warm the autoloads so the first interactive `zdot`/`pkg` call works: these
# files use the self-redefining autoload style, whose very first invocation only
# defines the function (subsequent calls run it). `zdot` is warmed naturally by
# `zdot load` in zprofile/zshrc, but nothing calls `pkg` at startup. This no
# longer pulls in compinit (that moved to zshrc.zsh, interactive-only).
zdot noop
pkg noop
