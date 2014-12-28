#!/usr/bin/env bash
#
# RVM and Ruby Setup
#
# This installs some of the common dependencies needed (or at least desired)
# using Ruby.

ppinfo 'Install Ruby'
ppinfo ' - Check for RVM'
if [ ! -d "$HOME/.rvm" ]; then
  ppinfo " - Installing RVM"
  curl -sSL https://get.rvm.io | bash -s stable --rails
fi

ppok ' - Ruby install complete'
exit 0
