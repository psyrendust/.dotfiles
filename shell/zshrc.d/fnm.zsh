#!/usr/bin/env zsh
#
# Init Fast Node Manager
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------
(( $+commands[fnm] )) || return 1

# Experimental options used
# @see https://github.com/Schniz/fnm/blob/master/docs/configuration.md
# ------------------------------------------------------------------------------
#
# --corepack-enabled
#   Runs corepack enable when a new version of Node.js is installed. Experimental
#   due to the fact Corepack itself is experimental.
# ------------------------------------------------------------------------------
#
# --resolve-engines
#   Treats package.json#engines#node as a valid Node.js version file ("dotfile").
#   So, if you have a package.json with teh following content:
#
#      { "engines": { "node": ">=20 <21" } }
#
#   - fnm install will install the latest satisfying Node.js 20.x version
#     available in the Node.js dist server
#   - fnm use will use the latest satisfying Node.js 20.x version available on
#     your system, or prompt to install if no version matched.
# ------------------------------------------------------------------------------
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines --shell zsh)"
