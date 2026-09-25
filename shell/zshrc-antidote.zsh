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
export PURE_GIT_PULL=1
# Do not include untracked files in dirtiness check. Mostly useful on large repos (like WebKit).
export PURE_GIT_UNTRACKED_DIRTY=0
# ------------------------------------------------------------------------------
### Custom pure prompt settings
# https://github.com/sindresorhus/pure#zstyle-options
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Show git stash status as part of the prompt.
zstyle :prompt:pure:git:stash show no

# ------------------------------------------------------------------------------
# You can set Pure to only git fetch the upstream branch of the current local
# branch. In some cases, this can result in faster updates for Git arrows, but
# for most users, it's better to leave this setting disabled.
zstyle :prompt:pure:git:fetch only_upstream no

# ------------------------------------------------------------------------------
# Node.js version display shows the current major node version when inside a directory tree containing a package.json.
zstyle :prompt:pure:environment:node_version show yes

# You can change the symbol shown before the Node.js version (default ⬢)
zstyle :prompt:pure:environment:node_version symbol '⬢'
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  # Add space after symbol to fix rendering bug with ghostty
  zstyle :prompt:pure:environment:node_version symbol '⬢ '
fi

# ------------------------------------------------------------------------------
# nix-shell integration adds the shell name to the prompt when used from within a nix shell.
zstyle :prompt:pure:environment:nix-shell show no

# ------------------------------------------------------------------------------
# Virtualenv integration shows the current Python virtualenv or Conda environment name.
zstyle :prompt:pure:environment:virtualenv show no

# ------------------------------------------------------------------------------
# Git integration
zstyle :prompt:pure:git show yes

# ------------------------------------------------------------------------------
# Detailed dirty indicators differentiate between unstaged (*), staged (+), and untracked (?) changes instead of showing a single *.
zstyle :prompt:pure:git:dirty detailed no

# ------------------------------------------------------------------------------
# Path separator dimming makes / characters in the path visually dimmer to help distinguish path components.
zstyle :prompt:pure:path:separator dim yes

# ------------------------------------------------------------------------------
# Hostname display is enabled by default when in an SSH session or container.
zstyle :prompt:pure:host show yes

# ------------------------------------------------------------------------------
# Automatic terminal title management can be disabled if you want to set your own tab or window titles
zstyle :prompt:pure:title show yes


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
zstyle ':omz:update' mode disabled
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:static' file "$ZDOT_ANTIDOTE_PLUGIN_CACHE"


# ------------------------------------------------------------------------------
### Load plugins
#
# Workplace plugins load first from the private work dotfiles repo (if present),
# with their own static cache so they don't clobber the main one.
# ------------------------------------------------------------------------------
[[ -f "$ZDOT_WORK_PLUGIN_CONFIG" ]] && \
  antidote load "$ZDOT_WORK_PLUGIN_CONFIG" "$ZDOT_WORK_PLUGIN_CACHE"

antidote load "$ZDOT_ANTIDOTE_PLUGIN_CONFIG"
