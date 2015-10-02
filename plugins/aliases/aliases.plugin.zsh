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
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ssh-bouncy="ssh -i ~/.ssh/famous/website.encrypted.pem ec2-user@bouncy-lego-42.phi42.net"
alias server="live-server"
alias simpleserver="python -m SimpleHTTPServer"
alias rmrf="rm -rf"

function ffdec() {
  local ffdec_exec="/Applications/JPEXS-Flash-Decompiler/ffdec_4.1.1/ffdec.jar"
  local java_exec="/usr/local/bin/java"
  $java_exec -jar $ffdec_exec $@ &
}

function lswhich() {
  echo $1
  ls -lAh $(which $1)
}

function mkcd() {
  dir="$*"
  mkdir -p "$dir" && cd "$dir"
}

function pf() {
  if [[ "$1" = "" ]]; then
    open -a "Path Finder.app" .
  else
    open -a "Path Finder.app" $1
  fi
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
