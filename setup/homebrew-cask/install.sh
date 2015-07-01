#!/usr/bin/env bash
#
# Homebrew Cask
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew Cask.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

ppinfo " - Update Homebrew cask"
brew cask update

ppinfo " - Audits your installation for common issues"
brew cask doctor

packages=(
  animated-gif-quicklook
  betterzipql
  cert-quicklook
  provisionql
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  qlvideo
  quicklook-csv
  quicklook-json
  quicknfo
  suspicious-package
  webpquicklook
)

ppinfo "Install homebrew cask packages"
for package in ${packages[@]}; do
  ppinfo " - Install cask $package"
  brew cask install $package && ppok " - Install cask $package"
done
unset package{,s}

ppinfo " - Uninstall unused and old versions of packages"
brew cask cleanup

# Enable text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

ppok " - Homebrew cask install complete"
exit 0
