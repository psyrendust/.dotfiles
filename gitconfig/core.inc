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
[gc]
  writeCommitGraph = true
[http]
  sslVerify = false


# Configure default Git settings for difftool and mergetool of choice.
# ------------------------------------------------------------------------------
[difftool]
  keepBackup = false
  prompt = false
  trustExitCode = true
[mergetool]
  keepBackup = false
  prompt = false
  trustExitCode = true


# Sign commits with GPG
# ------------------------------------------------------------------------------
[credential]
  helper = osxkeychain
[gpg "ssh"]
	allowedSignersFile = ~/.ssh/allowed_signers


# How Core Git Developers Configure Git
# https://blog.gitbutler.com/how-git-core-devs-configure-git/
# Makes git better
# ------------------------------------------------------------------------------
[branch]
  sort = -committerdate
[tag]
  sort = version:refname
[init]
  defaultBranch = main
[diff]
  algorithm = histogram
  colorMoved = plain
  mnemonicPrefix = true
  renames = true
[push]
  default = simple
  autoSetupRemote = true
  followTags = true
[fetch]
  prune = true
  pruneTags = true
  all = true


# How Core Git Developers Configure Git
# Why the hell not?
# https://blog.gitbutler.com/how-git-core-devs-configure-git/#why-the-hell-not
# ------------------------------------------------------------------------------
[help]
  autocorrect = prompt
[commit]
  verbose = true
[rerere]
  enable = true
  autoUpdate = true
[rebase]
  autoSquash = true
  autoStash = true
  updateRefs = true


# How Core Git Developers Configure Git
# A matter of taste
# https://blog.gitbutler.com/how-git-core-devs-configure-git/#a-matter-of-taste
# ------------------------------------------------------------------------------
[core]
  fsmonitor = true
  untrackedCache = true
[pull]
  rebase = true
