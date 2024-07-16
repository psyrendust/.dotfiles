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
### Initialize antidote
# https://getantidote.github.io
# ------------------------------------------------------------------------------
if [[ ! -d ~/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
  source ~/.antidote/antidote.zsh
else
  source ~/.antidote/antidote.zsh
fi


# ------------------------------------------------------------------------------
### My prompt
# ------------------------------------------------------------------------------
# Prevents Pure from checking whether the current Git remote has been updated.
export PURE_GIT_PULL=0
# Do not include untracked files in dirtiness check. Mostly useful on large repos (like WebKit).
export PURE_GIT_UNTRACKED_DIRTY=0


# ------------------------------------------------------------------------------
### Configure antidote variables
# Customize the home directory for antidote.
# Customize the name of the plugins file.
# Customize the cache file for the plugins.
# ------------------------------------------------------------------------------
export ANTIDOTE_HOME=~/.cache/antidote
export ZDOT_ANTIDOTE_PLUGINS_NAME="zshrc-antidote-plugins"
export ZDOT_ANTIDOTE_PLUGIN_CACHE="$ZDOT_CACHE/$ZDOT_ANTIDOTE_PLUGINS_NAME.zsh"
export ZDOT_ANTIDOTE_PLUGIN_CONFIG="$ZDOT_SHELL/$ZDOT_ANTIDOTE_PLUGINS_NAME.conf"


# ------------------------------------------------------------------------------
### Override default settings
# ------------------------------------------------------------------------------
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:static' file "$ZDOT_ANTIDOTE_PLUGIN_CACHE"


# ------------------------------------------------------------------------------
### Load plugins
# ------------------------------------------------------------------------------
antidote load "$ZDOT_ANTIDOTE_PLUGIN_CONFIG"
