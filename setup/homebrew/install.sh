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

ppinfo "Install Homebrew"
ppinfo " - Check for Homebrew"
if test ! $(which brew)
then
  ppinfo " - Installing Homebrew for you"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

ppinfo " - Update the formulae and Homebrew"
brew update

ppinfo " - Upgrade outdated formulae"
brew upgrade

ppinfo " - Audits your installation for common issues"
brew doctor

packages=(
  asciinema
  autoconf
  automake
  bash
  coreutils
  fasd
  ffmpeg
  freetype
  gdbm
  git
  git-flow
  go
  imagemagick
  libgpg-error
  libksba
  libvo-aacenc
  libyaml
  mackup
  nvm
  openssl
  pcre
  pkg-config
  readline
  tree
  zsh
)

ppinfo "Install homebrew packages"
for package in ${packages[@]}; do
  ppinfo " - Install $package"
  brew install $package && ppok " - Install $package"
done
unset package{,s}

ppinfo " - Install imagemagick homebrew package"
brew install imagemagick --with-libtiff

ppinfo " - Uninstall unused and old versions of packages"
brew cleanup

if test ! $(cat /etc/shells | grep "/usr/local/bin/bash")
then
  sudo echo "/usr/local/bin/bash" >> /etc/shells && ppinfo " - Add bash to /etc/shells"
fi

if test ! $(cat /etc/shells | grep "/usr/local/bin/zsh")
then
  sudo echo "/usr/local/bin/zsh" >> /etc/shells && ppinfo " - Add zsh to /etc/shells"
fi

ppinfo "Setup GOPATH folder"
mkdir -p $HOME/.go

ppinfo "Setup nvm correctly"
ppinfo "Add NVM's working directory to your \$HOME path (if it doesn't exist):"
mkdir -p $HOME/.nvm

ppinfo "Symlink nvm-exec to NVM's working directory"
ln -sf "$(brew --prefix nvm)/nvm-exec" "$HOME/.nvm/nvm-exec"

ppok " - Homebrew install complete"
exit 0
