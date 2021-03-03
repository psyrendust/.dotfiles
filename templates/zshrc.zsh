#!/usr/bin/env zsh
#
# Define environment variables for login, non-login, interactive and
# non-interactive shells.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshrc
#   #!/usr/bin/env zsh
#   [[ -n $DOTFILES_DEBUG ]] && echo "$HOME/.zshrc"
#   zdot load "$ZDOT_TEMPLATES/zshrc.zsh"
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
__path_pre+=("$ZDOT_PLUGINS/vscode/bin")
__path_pre+=("$ZDOT_BIN")
__path_pre+=("$HOME/.tmpbin")


# Add GOPATH and GOROOT
[[ -d "$GOPATH" ]] && [[ -d "$GOPATH/bin" ]] && __path_pre+=("$GOPATH/bin")
[[ -d "$GOROOT" ]] && [[ -d "$GOROOT/bin" ]] && __path_pre+=("$GOROOT/bin")

# Add homebrews bin
[[ -z $(echo $PATH | grep "/usr/local/bin") ]] && __path_pre+=("/usr/local/bin")

# Add manpath
__manpath_pre+=("/usr/local/share/man")


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
# Load up nvm
# nvm.sh -> to thwart nvm's install.sh
# zdot load "$ZDOT_TEMPLATES/init_nvm" # Load nvm


# ------------------------------------------------------------------------------
# Load up necessary scripts
# ------------------------------------------------------------------------------
# Load any private scripts
zdot load "$ZDOT_DROPBOX_APPS/index.zsh"


# ------------------------------------------------------------------------------
# check install
# ------------------------------------------------------------------------------
zdot load "$ZDOT_TEMPLATES/check-install.zsh"


# ------------------------------------------------------------------------------
# Initialize zplug
# ------------------------------------------------------------------------------
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
else
  source ~/.zplug/init.zsh
fi


# ------------------------------------------------------------------------------
# om-my-zsh startup files
# ------------------------------------------------------------------------------
zplug "robbyrussell/oh-my-zsh", use:"oh-my-zsh.sh"


# ------------------------------------------------------------------------------
# om-my-zsh plugins
# ------------------------------------------------------------------------------
zplug "plugins/colorize", from:oh-my-zsh, defer:1
zplug "plugins/command-not-found", from:oh-my-zsh, defer:1
zplug "plugins/copydir", from:oh-my-zsh, defer:1
zplug "plugins/copyfile", from:oh-my-zsh, defer:1
zplug "plugins/cp", from:oh-my-zsh, defer:1
zplug "plugins/encode64", from:oh-my-zsh, defer:1
zplug "plugins/extract", from:oh-my-zsh, defer:1
zplug "plugins/fasd", from:oh-my-zsh, defer:1
zplug "plugins/fd", from:oh-my-zsh, defer:1
zplug "plugins/git", from:oh-my-zsh, defer:1
zplug "plugins/man", from:oh-my-zsh, defer:1
zplug "plugins/osx", from:oh-my-zsh, defer:1
zplug "plugins/systemadmin", from:oh-my-zsh, defer:1
zplug "plugins/urltools", from:oh-my-zsh, defer:1
zplug "plugins/yarn", from:oh-my-zsh, defer:1


# ------------------------------------------------------------------------------
# misc plugins
# ------------------------------------------------------------------------------
zplug "/usr/local/opt/fzf", from:local, use:"shell/*.zsh", defer:2
zplug "bigH/git-fuzzy", as:command, use:"bin/git-fuzzy", defer:2


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
zplug "so-fancy/diff-so-fancy", as:command, defer:0
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-syntax-highlighting", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:3


# ------------------------------------------------------------------------------
# My theme
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
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi


# ------------------------------------------------------------------------------
# Then, source packages and add commands to $PATH
# ------------------------------------------------------------------------------
zplug load
