# OS X Git configuration.
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

[core]
	commitGraph = true
  editor = gitcommiteditor
  # editor = vi
  excludesfile = $HOME/.dotfiles/templates/gitignore_global
  filemode = false
  hidedotfiles = false
  trustctime = false
  whitespace = fix
[gc]
	writeCommitGraph = true
[http]
  sslVerify = false


# Configure default Git settings for difftool and mergetool of choice.
# ------------------------------------------------------------------------------
[diff]
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
