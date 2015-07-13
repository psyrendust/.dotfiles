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

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓"

function __prompt-scm-char {
  # Setup some SCM characters
  local SCM=''
  local SCM_GIT='git'
  local SCM_GIT_CHAR='±'
  local SCM_HG='hg'
  local SCM_HG_CHAR='☿'
  local SCM_SVN='svn'
  local SCM_SVN_CHAR='⑆'
  local SCM_NONE='NONE'
  local SCM_NONE_CHAR='○'
  # Get the current SCM
  if [[ -f .git/HEAD ]]; then SCM=$SCM_GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$SCM_GIT
  elif [[ -d .hg ]]; then SCM=$SCM_HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$SCM_HG
  elif [[ -d .svn ]]; then SCM=$SCM_SVN
  else SCM=$SCM_NONE
  fi

  # Get the SCM character
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  elif [[ $SCM == $SCM_HG ]]; then SCM_CHAR=$SCM_HG_CHAR
  elif [[ $SCM == $SCM_SVN ]]; then SCM_CHAR=$SCM_SVN_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
  echo $SCM_CHAR
}

function __PROMPT_LINE_1 {
  local CURRENT_USER="%{$fg[magenta]%}%n%{$reset_color%}"   # Grab the current username
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

function __PROMPT_LINE_2 {
  echo "%{$fg_bold[cyan]%}\$(__prompt-scm-char)%{$reset_color%}\$(git_prompt_info)%{$fg[green]%} →%{$reset_color%} "
}

PROMPT="
$(__PROMPT_LINE_1)
$(__PROMPT_LINE_2)"

