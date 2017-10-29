#!/usr/bin/env zsh
#
# Psyrendust prompt theme for Zsh.
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

ZSH_THEME_NODE_DIVIDER_PREFIX="%{$fg[magenta]%}["
ZSH_THEME_NODE_DIVIDER_SUFFIX="%{$fg[magenta]%}]"
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓"

# Setup some SCM characters
ZSH_THEME_SCM_GIT='git'
ZSH_THEME_SCM_GIT_CHAR='±'
ZSH_THEME_SCM_HG='hg'
ZSH_THEME_SCM_HG_CHAR='☿'
ZSH_THEME_SCM_SVN='svn'
ZSH_THEME_SCM_SVN_CHAR='⑆'
ZSH_THEME_SCM_NONE='NONE'
ZSH_THEME_SCM_NONE_CHAR='○'

function __prompt-scm-current() {
  local SCM=''
  if [[ -f .git/HEAD ]]; then SCM=$ZSH_THEME_SCM_GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$ZSH_THEME_SCM_GIT
  elif [[ -d .hg ]]; then SCM=$ZSH_THEME_SCM_HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$ZSH_THEME_SCM_HG
  elif [[ -d .svn ]]; then SCM=$ZSH_THEME_SCM_SVN
  else SCM=$ZSH_THEME_SCM_NONE
  fi
  echo $SCM
}

function __prompt-scm-char() {
  local SCM_CHAR=''
  local SCM_CURR=$(__prompt-scm-current)

  # Get the SCM character
  if [[ $SCM_CURR == $ZSH_THEME_SCM_GIT ]]; then SCM_CHAR=$ZSH_THEME_SCM_GIT_CHAR
  elif [[ $SCM_CURR == $ZSH_THEME_SCM_SVN ]]; then SCM_CHAR=$ZSH_THEME_SCM_SVN_CHAR
  elif [[ $SCM_CURR == $ZSH_THEME_SCM_HG ]]; then SCM_CHAR=$ZSH_THEME_SCM_HG_CHAR
  else SCM_CHAR=$ZSH_THEME_SCM_NONE_CHAR
  fi
  echo $SCM_CHAR
}

function __prompt-nvm-get-version() {
  echo "%{$fg[magenta]%}nvm $(node -v)%{$reset_color%}"
}

function __PROMPT_LINE_1() {
  local CURRENT_USER="%{$fg_bold[magenta]%}%n%{$reset_color%}"   # Grab the current username
  local IN="%{$fg[white]%}in%{$reset_color%}"               # Just some text
  local CURRENT_PATH="%{$fg[green]%}%~"                     # Grab the current file path
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`      # Get the current IP for the SSH session
  local CURRENT_LOCATION=""

  # Am I root?
  [ `whoami` = "root" ] && CURRENT_USER="%{$fg[red]%}%n%{$reset_color%}"

  # Current location is remote
  [ $SSH_IP ] && CURRENT_LOCATION="%{$fg[yellow]%}[ssh@$SSH_IP]%{$reset_color%} "

  echo "$CURRENT_LOCATION$CURRENT_USER $IN $CURRENT_PATH"
}

function __PROMPT_LINE_2() {
  # local CURRENT_NODE_VERSION="%{$fg[magenta]%}node: $(node -v)%{$reset_color%}"
  local GIT_PROMPT_INFO="\$(git_prompt_info)"

  # local SCM_CHAR="%{$fg_bold[cyan]%}\$(__prompt-scm-char)%{$reset_color%}"
  # local PSYRENDUST_PROMPT="%{$fg[green]%}→%{$reset_color%}"

  echo "$ZSH_THEME_NODE_DIVIDER_PREFIX\$(__prompt-nvm-get-version)$ZSH_THEME_NODE_DIVIDER_SUFFIX$GIT_PROMPT_INFO"
}

function __PROMPT_LINE_3() {
  local SCM_CHAR="%{$fg_bold[cyan]%}\$(__prompt-scm-char)%{$reset_color%}"
  local PSYRENDUST_PROMPT="%{$fg[green]%}→%{$reset_color%}"

  echo "$SCM_CHAR $PSYRENDUST_PROMPT "
}

function __PROMPT_LINE_4() {
  local GIT_PROMPT_INFO="\$(git_prompt_info)"
  local SCM_CHAR="%{$fg_bold[cyan]%}\$(__prompt-scm-char)%{$reset_color%}"
  local PSYRENDUST_PROMPT="%{$fg[green]%}→%{$reset_color%}"

  echo "$SCM_CHAR $GIT_PROMPT_INFO $PSYRENDUST_PROMPT "
}

# PROMPT="
# $(__PROMPT_LINE_1)
# $(__PROMPT_LINE_2)
# $(__PROMPT_LINE_3)"
PROMPT="
$(__PROMPT_LINE_1)
$(__PROMPT_LINE_4)"
