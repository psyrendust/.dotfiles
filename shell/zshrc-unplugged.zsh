#!/usr/bin/env zsh
#
# Define aliases, functions, shell options, and key bindings.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshrc
#   #!/usr/bin/env zsh
#   zdot load "$ZDOT_SHELL/zshrc.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Initialize zplug
# ------------------------------------------------------------------------------
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/mattmc3/zsh_unplugged ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
else
  source ~/.zplug/init.zsh
fi


# ------------------------------------------------------------------------------
# om-my-zsh startup files
# ------------------------------------------------------------------------------
zplug "robbyrussell/oh-my-zsh", use:"oh-my-zsh.sh", defer:0


# ------------------------------------------------------------------------------
# om-my-zsh plugins
# ------------------------------------------------------------------------------
zplug "plugins/colorize", from:oh-my-zsh, defer:1
zplug "plugins/command-not-found", from:oh-my-zsh, defer:1
zplug "plugins/copyfile", from:oh-my-zsh, defer:1
zplug "plugins/copypath", from:oh-my-zsh, defer:1
zplug "plugins/cp", from:oh-my-zsh, defer:1
zplug "plugins/encode64", from:oh-my-zsh, defer:1
zplug "plugins/extract", from:oh-my-zsh, defer:1
zplug "plugins/fd", from:oh-my-zsh, defer:1
zplug "plugins/git", from:oh-my-zsh, defer:1
zplug "plugins/macos", from:oh-my-zsh, defer:1
zplug "plugins/man", from:oh-my-zsh, defer:1
zplug "plugins/systemadmin", from:oh-my-zsh, defer:1
zplug "plugins/urltools", from:oh-my-zsh, defer:1


# ------------------------------------------------------------------------------
# misc plugins
# ------------------------------------------------------------------------------
zplug "$ZDOT_BREW_ROOT/opt/fzf", from:local, use:"shell/*.zsh", defer:1
zplug "bigH/git-fuzzy", as:command, use:"bin/git-fuzzy", defer:1
zplug "lukechilds/zsh-nvm", defer:1
zplug "agkozak/zsh-z", defer:1


# ------------------------------------------------------------------------------
# dotfiles plugins
# ------------------------------------------------------------------------------
zplug "$ZDOT_PLUGINS/aliases", from:local, defer:2
zplug "$ZDOT_PLUGINS/colored-man-pages", from:local, defer:2
zplug "$ZDOT_PLUGINS/fzf", from:local, defer:2
zplug "$ZDOT_PLUGINS/git", from:local, defer:2
zplug "$ZDOT_PLUGINS/git-fuzzy", from:local, defer:2


# ------------------------------------------------------------------------------
# zsh plugins
# ------------------------------------------------------------------------------
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-syntax-highlighting", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:3


# ------------------------------------------------------------------------------
# My prompt
# ------------------------------------------------------------------------------
# Prevents Pure from checking whether the current Git remote has been updated.
export PURE_GIT_PULL=0
# Do not include untracked files in dirtiness check. Mostly useful on large repos (like WebKit).
export PURE_GIT_UNTRACKED_DIRTY=0

zplug "mafredri/zsh-async", from:github, defer:2
zplug "sindresorhus/pure", use:"pure.zsh", from:github, as:theme, defer:3


# ------------------------------------------------------------------------------
# Check for missing packages and install them if missing
# ------------------------------------------------------------------------------
# if ! zplug check --verbose; then
#   printf "Install? [y/N]: "
#   if read -q; then
#     echo; zplug install
#   fi
# fi


# ------------------------------------------------------------------------------
# Then, source packages and add commands to $PATH
# ------------------------------------------------------------------------------
zplug load
