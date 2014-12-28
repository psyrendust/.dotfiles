#!/usr/bin/env bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

ppinfo 'Install Homebrew'
ppinfo ' - Check for Homebrew'
if test ! $(which brew)
then
  ppinfo " - Installing Homebrew for you"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log
fi

ppinfo ' - Update the formulae and Homebrew'
brew update

ppinfo ' - Upgrade outdated formulae'
brew upgrade

ppinfo ' - Audits your installation for common issues'
brew doctor

ppinfo ' - Install homebrew packages'
brew install coreutils git git-flow node bash zsh fasd

ppinfo ' - Install imagemagick homebrew package'
brew install imagemagick --with-libtiff

ppinfo ' - Uninstall unused and old versions of packages'
brew cleanup

ppok ' - Homebrew install complete'
exit 0
