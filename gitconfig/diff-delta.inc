# OS X Git configuration to use git-delta for git and diff output
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
#
# @see https://github.com/dandavison/delta
# ------------------------------------------------------------------------------
[interactive]
  diffFilter = delta --color-only --features=interactive

[delta]
  dark = true
  decorations = true
  hyperlinks = true
  hyperlinks-file-link-format = "vscode://file/{path}:{line}"
  line-numbers = true
  navigate = true
  syntax-theme = TwoDark
  true-color = always
  minus-style = white bold "#660002"

[delta "interactive"]
  keep-plus-minus-markers = false

[delta "decorations"]
  commit-decoration-style = blue ol
  commit-style = syntax
#   file-style = omit
  hunk-header-decoration-style = blue ul ol
  hunk-header-file-style = blue
#   hunk-header-line-number-style = blue
  hunk-header-style = file line-number syntax

[delta "line-numbers"]
    line-numbers-left-style = cyan
    line-numbers-right-style = cyan
    line-numbers-minus-style = 124
    line-numbers-plus-style = 28
