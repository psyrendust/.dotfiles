#!/usr/bin/env bash
#
# rvm and Ruby Setup
#
# This installs some of the common dependencies needed (or at least desired)
# using Ruby.

ppinfo 'Install rvm'
ppinfo ' - Check for rvm'
if test ! $(which rvm)
then
  ppinfo " - Installing RVM"
  curl -sSL https://get.rvm.io | bash -s stable --rails
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

ppok ' - Ruby install complete'
exit 0
