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

BATMAN="bat --plain --color=always --theme=Dracula --language=man"
export MANPAGER="sh -c 'col -bx | $BATMAN'"

function man {
  local MAN="/usr/bin/man"
  if [ -n "$1" ]; then
    $MAN "$@"
    return $?
  else
    # sed regex to extract the man page section and name
    # Converts `git-pull(1)` to `1 git-pull`
    local SED_REGEX="(.*)\((.*)\)[,]*/\2 \1"
    # Use fzf to search all man pages
    r1=$($MAN -k . | awk '{print $1}' | fzf --reverse --preview="echo {} | awk '{print $1}' | sed -E 's/$SED_REGEX/g' | xargs -r $MAN")
    # Open the results of r1 in man
    echo "$r1" | sed -E 's/$SED_REGEX/g' | xargs -r $MAN
  fi
}
