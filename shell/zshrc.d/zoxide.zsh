#!/usr/bin/env zsh
#
# Init Zoxide
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------
(( $+commands[zoxide] )) || return 1
eval "$(zoxide init zsh)"
