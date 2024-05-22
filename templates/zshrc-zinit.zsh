#!/usr/bin/env zsh
#
# Define aliases, functions, shell options, and key bindings.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshrc
#   #!/usr/bin/env zsh
#   zdot load "$ZDOT_TEMPLATES/zshrc.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/templates/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# zinit init
# ------------------------------------------------------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# ------------------------------------------------------------------------------
# My theme
# ------------------------------------------------------------------------------
# Prevents Pure from checking whether the current Git remote has been updated.
export PURE_GIT_PULL=0
# Do not include untracked files in dirtiness check. Mostly useful on large repos (like WebKit).
export PURE_GIT_UNTRACKED_DIRTY=0
zinit light mafredri/zsh-async
zinit light sindresorhus/pure

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Manual test config below
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# zi init
# ------------------------------------------------------------------------------
### Added by zi's installer
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands
### End of zi's installer chunk


# ------------------------------------------------------------------------------
# My prompt
# ------------------------------------------------------------------------------
# Prevents Pure from checking whether the current Git remote has been updated.
export PURE_GIT_PULL=0
# Do not include untracked files in dirtiness check. Mostly useful on large repos (like WebKit).
export PURE_GIT_UNTRACKED_DIRTY=0
zi ice pick"async.zsh" src"pure.zsh"
zi light "sindresorhus/pure"


# ------------------------------------------------------------------------------
# om-my-zsh startup files
# ------------------------------------------------------------------------------
# zi snippet OMZ

# ------------------------------------------------------------------------------
# om-my-zsh plugins
# ------------------------------------------------------------------------------
zi snippet OMZP::colorize
zi snippet OMZP::command-not-found
zi snippet OMZP::copyfile
zi snippet OMZP::copypath
zi snippet OMZP::cp
zi snippet OMZP::encode64
zi snippet OMZP::extract
zi snippet OMZP::git
# zi snippet OMZP::macos
zi snippet OMZP::man
zi snippet OMZP::systemadmin
zi snippet OMZP::urltools
# zi snippet OMZP::yarn

# ------------------------------------------------------------------------------
# completions
# ------------------------------------------------------------------------------
zi ice as"completion"
zi snippet OMZ::plugins/fd/_fd
zi ice as"completion"
zi load "$ZDOT_BREW_ROOT/opt/fzf/shell/completion.zsh"

# ------------------------------------------------------------------------------
# misc plugins
# ------------------------------------------------------------------------------
zi load "$ZDOT_BREW_ROOT/opt/fzf" pick"shell/*.zsh"
# zplug "bigH/git-fuzzy", as:command, use:"bin/git-fuzzy", defer:1
# zplug "lukechilds/zsh-nvm", defer:1
# zplug "agkozak/zsh-z", defer:1


# ------------------------------------------------------------------------------
# dotfiles plugins
# ------------------------------------------------------------------------------
# zi ice wait"1"
zi load "$ZDOT_PLUGINS/aliases"
zi load "$ZDOT_PLUGINS/colored-man-pages"
zi load "$ZDOT_PLUGINS/fzf"
zi load "$ZDOT_PLUGINS/git"
zi load "$ZDOT_PLUGINS/git-fuzzy"


# ------------------------------------------------------------------------------
# zsh plugins
# ------------------------------------------------------------------------------
zi ice blockf atpull'zi creinstall -q .'
zi light zsh-users/zsh-completions

# Autosuggestions & fast-syntax-highlighting
zi ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zi light zdharma-continuum/fast-syntax-highlighting
# zsh-autosuggestions
zi ice wait lucid atload"!_zsh_autosuggest_start"
zi load zsh-users/zsh-autosuggestions

# autoload compinit
# compinit

# zi light zsh-users/zsh-syntax-highlighting
# zi light zsh-users/zsh-history-substring-search
# zi ice wait atload'_history_substring_search_config'

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
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
# zplug load
