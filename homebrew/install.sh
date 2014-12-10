#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log
fi

# Update the formulae and Homebrew
brew update

# Upgrade outdated formulae
brew upgrade

# Audits your installation for common issues
brew doctor

# Install homebrew packages
brew install coreutils git git-flow node bash zsh fasd

# Uninstall unused and old versions of packages
brew cleanup

exit 0
