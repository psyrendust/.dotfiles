# OS X Git configuration to use diff-so-fancy for git and diff output
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
#
# @see https://github.com/so-fancy/diff-so-fancy
# ------------------------------------------------------------------------------
[color]
  ui = true

[color "diff-highlight"]
  oldHighlight = red bold 52
  newNormal = green bold
  newHighlight = green bold 22
  oldNormal = red bold

[color "diff"]
  meta = 11
  frag = magenta bold
  func = 146 bold
  commit = yellow bold
  old = red bold
  new = green bold
  whitespace = red reverse

[core]
  pager = "diff-so-fancy | less --tabs=4 -R"

[interactive]
  diffFilter = "diff-so-fancy --patch"

[diff-so-fancy]
  changeHunkIndicators = true
  markEmptyLines = true
  stripLeadingSymbols = true
  useUnicodeRuler = true
