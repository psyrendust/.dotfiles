#!/usr/bin/env zsh
#
# Open path or files in Sublime Text 3 or Sublime Text 2.
#
# Author:
#   Larry Gordon
#
# Usage:
#   $ sbl .
#   $ sbl filename.txt
#   $ sbl file1.txt file2.txt
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------


# Create a symlink in the background, because it can be slow on some machines
{
  # OS X paths
  if [[ -n $PLATFORM_IS_MAC ]]; then
    sublime_paths=(
      "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
      "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"
      "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
      "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
      "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"
      "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
    )
  elif [[ -n $PLATFORM_IS_LINUX ]]; then
    # Linux paths
    sublime_path+=(
      "$HOME/bin/sublime_text"
      "/opt/sublime_text/sublime_text"
      "/usr/bin/sublime_text"
      "/usr/local/bin/sublime_text"
      "/usr/bin/subl"
    )
  elif [[ -n $PLATFORM_IS_CYGWIN ]]; then
    # Windows paths
    sublime_path+=(
      "/cygdrive/c/Program Files/Sublime Text 3/sublime_text.exe"
      "/cygdrive/c/Program Files/Sublime Text 2/sublime_text.exe"
    )
  fi
  for sublime_path in $sublime_paths; do
    if [[ -a $sublime_path ]]; then
      ln -sf "$sublime_path" "/usr/local/bin/subl"
      break
    fi
  done
} &!

sbl() {
  if  [[ -n $PLATFORM_IS_MAC ]]; then
    subl $@
  elif  [[ -n $PLATFORM_IS_CYGWIN ]]; then
    cygstart /usr/local/bin/subl $(cygpath -w $@)
  elif [[ -n $PLATFORM_IS_LINUX ]]; then
    nohup /usr/local/bin/subl $@ > /dev/null &
  fi
}
