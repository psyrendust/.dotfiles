#!/usr/bin/env bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

set -eu

err() {
    (set +u; # allow calling with no arguments
        echo "${@}" >&2
    )
}

fail() {
    err
    err "!!!!!!!!!!!!!!!!!!!!!!!!"
    err "!! The script failed. !!"
    err "!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
}

ppinfo "Install powerline fonts"

pre_install() {
  mkdir -p $ZSH_CUSTOM/tmp
  git clone https://github.com/powerline/fonts.git --depth=1 $ZSH_CUSTOM/tmp/fonts
}

install_fonts() {
  . $ZSH_CUSTOM/tmp/fonts/install.sh
}

post_install() {
  rm -rf $ZSH_CUSTOM/tmp
}

pre_install || fail
install_fonts || fail
post_install || fail

ppok " - Powerline fonts install complete"