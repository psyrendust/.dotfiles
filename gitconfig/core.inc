# OS X Git configuration
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# less configuration
# ------------------------------------------------------------------------------
# -F:  Quit if entire file fits on first screen.
# -R:  Output "raw" control characters.
# -S:  Chop (truncate) long lines rather than wrapping.
#
# ------------------------------------------------------------------------------
# Don't use these options if you want to be able to scroll and copy text.
# This causes problems when using things like diff or log.
# ------------------------------------------------------------------------------
# Enabling -X prevents scrolling.
# -X:  Don't clear the screen after quitting less
# ------------------------------------------------------------------------------
# Enabling mouse input prevents selection and copying in iTerm2.
# --mouse:          Enable mouse input.
# --wheel-lines=N:  Each click of the mouse wheel moves N lines.
# ------------------------------------------------------------------------------

[color]
  ui = true
[core]
  commitGraph = true
  editor = gitcommiteditor
  excludesfile = $HOME/.dotfiles/templates/gitignore_global
  filemode = false
  hidedotfiles = false
  pager = delta
  trustctime = false
  whitespace = fix
[init]
  defaultBranch = main
[gc]
  writeCommitGraph = true
[http]
  sslVerify = false


# Configure default Git settings for difftool and mergetool of choice.
# ------------------------------------------------------------------------------
[diff]
  colorMoved = default
  renames = true
[difftool]
  keepBackup = false
  prompt = false
  trustExitCode = true
[mergetool]
  keepBackup = false
  prompt = false
  trustExitCode = true


# User configuration stuff
# ------------------------------------------------------------------------------
[credential]
  helper = osxkeychain
[help]
  autocorrect = 1
[push]
  default = current
