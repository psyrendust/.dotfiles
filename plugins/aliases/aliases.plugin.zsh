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
alias npmlist="npm list --depth=0"
alias rmrf="rm -rf"

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

function mkcd() {
  dir="$*"
  mkdir -p "$dir" && cd "$dir"
}
