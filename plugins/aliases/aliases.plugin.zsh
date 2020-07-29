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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias server="live-server"
alias simpleserver="python -m SimpleHTTPServer"
alias rmrf="rm -rf"
alias changelogreset="conventional-changelog -p angular -i CHANGELOG.md -s -r 0"
alias l='ls -CFH'
alias la='l -A'
alias li='l -l'
alias ll='la -l'
alias dotfiles='code ~/.dotfiles'
alias version="cat package.json | jq '.version'"
alias scripts="cat package.json | jq '.scripts'"

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

_pluginsAliases="$ZSH_CUSTOM/plugins/aliases"
for plugin in $_pluginsAliases/*.zsh; do
  if [ "$plugin" != "$_pluginsAliases/aliases.plugin.zsh" ]; then
    source "$plugin" 2>&1
  fi
done
unset _pluginsAliases
