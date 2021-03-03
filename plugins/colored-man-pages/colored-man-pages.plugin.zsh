#!/usr/bin/env zsh
#
# Colored man pages using fzf and batman
#
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

function man dman debman {
  local MAN="/usr/bin/man"
  if [ -n "$1" ]; then
    batman "$@"
    return $?
  else
    r1=$($MAN -k . | awk '{print $1}' | fzf --reverse --preview="echo {} | awk '{print $1}' | sed -E 's/\(.*\)[,]*//g' | xargs batman --color=always")
    r2=$(echo "$r1" | sed -E 's/\(.*\)[,]*//g')
    batman $r2 "$@"
  fi
}
