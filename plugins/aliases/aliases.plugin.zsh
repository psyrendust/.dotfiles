#!/usr/bin/env zsh
#
# Custom aliases
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# Add zsh help
unalias run-help > /dev/null 2>&1
autoload run-help
HELPDIR=/usr/local/share/zsh/help

[[ -d $HOME/.rvm/bin ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias cat='bat --paging=never'
alias catp='bat'
alias ccat='/bin/cat'
alias changelogreset="conventional-changelog -p angular -i CHANGELOG.md -s -r 0"
# Clear screen and reset scroll-back
# @see https://apple.stackexchange.com/questions/31872/how-do-i-reset-the-scrollback-in-the-terminal-via-a-shell-command/113168#113168
alias klear="clear && printf '\e[3J'"
alias l='ls -CFH'
alias la='l -A'
# alias li='l -l'
# alias ll='la -l'
# Use https://github.com/ogham/exa
alias li='eza -lgh --group-directories-first'
alias ll='li -a'

alias rmrf="rm -rf"
alias server="live-server"
alias version="cat package.json | jq '.version'"

# Removing ANSI color codes from text stream
# https://superuser.com/a/561105
alias stripcolors="perl -pe 's/\x1b\[[0-9;]*[mG]//g'"

function ffdec() {
  local ffdec_exec="/Applications/JPEXS-Flash-Decompiler/ffdec_4.1.1/ffdec.jar"
  local java_exec="/usr/local/bin/java"
  $java_exec -jar $ffdec_exec $@ &
}

function findinprojects() {
  local pattern="$1"
  grep -rnIw --exclude-dir=".git" --exclude-dir="node_modules" -e "$pattern" $@
}

# Install multiple versions of java sdk
# brew tap homebrew/cask-versions
# Install java 1.8
# brew cask install adoptopenjdk8
function java8() {
  local JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
  export JAVA_HOME=$JAVA_8_HOME
}

function java11() {
  local JAVA_11_HOME=$(/usr/libexec/java_home -v11)
  export JAVA_HOME=$JAVA_11_HOME
}

function landed() {
  local githead="$(git rev-parse --short HEAD)"
  echo "Landed in $githead" | pbcopy
}

function lswhich() {
  echo $1
  ls -lAh $(which $1)
}

function mark() {
  open -a "Marked 2" $@;
}

function mkcd() {
  dir="$*"
  mkdir -p "$dir" && cd "$dir"
}

function rem() {
  # words, sentences or paragraphs
  local units="words"
  local lowercase="false"
  local count=3
  for arg in ${@}; do
    if [[ $arg =~ '^[0-9]+$' ]]; then count=$arg;
    elif [[ "$arg" == "-w" ]]; then units="words";
    elif [[ "$arg" == "-s" ]]; then units="sentences";
    elif [[ "$arg" == "-p" ]]; then units="paragraphs";
    elif [[ "$arg" == "-l" ]]; then lowercase="true";
    fi
  done
  local str="$(lorem-ipsum --units $units --copy --format plain --count $count)"
  [[ $lowercase == "false" ]] && str="$(echo ${str:0:1} | tr '[a-z]' '[A-Z]')${str:1}"
  echo "$str" | pbcopy
  echo "$str"
}

function rmlock() {
  # Remove .git/index.lock
  local lockfile="$(git rev-parse --show-toplevel)/.git/index.lock"
  if [[ -f "$lockfile" ]]; then
    rm "$lockfile"
    echo "removed $lockfile"
  fi
}

# _pluginsAliases="$ZDOT_PLUGINS/aliases"
# for plugin in $_pluginsAliases/*.zsh; do
#   if [ "$plugin" != "$_pluginsAliases/aliases.plugin.zsh" ]; then
#     source "$plugin" 2>&1
#   fi
# done
# unset _pluginsAliases
