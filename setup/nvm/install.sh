#!/usr/bin/env bash
#
# Install nvm, NodeJS, and npm
#
# This installs some of the common dependencies needed (or at least desired)
# using NodeJS.
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

set -eu

ppinfo "Install nvm"

export NVM_DIR=$HOME/.nvm
[[ -s "$(brew --prefix nvm)/nvm.sh" ]] && source $(brew --prefix nvm)/nvm.sh

ppinfo " - Check for nvm"
if test ! $(nvm --version)
then
  ppinfo " - Installing nvm"
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" # This loads nvm"

ppinfo " - Install latest stable NodeJS"
nvm install stable
nvm alias default stable
nvm alias sublime $(node -v)

packages=(
  babel
  babel-cli
  babel-eslint
  david
  eslint
  eslint-config-airbnb
  eslint-config-airbnb-base
  eslint-plugin-import
  eslint-plugin-jsx-a11y
  eslint-plugin-react
  githubrelease
  grunt
  grunt-cli
  gulp
  jshint
  json
  live-server
  lorem-ipsum
  nodemon
  npm
  trash-cli
  webpack
  yo
)

postpackages=(
)

ppinfo "Install npm packages"
for package in ${packages[@]}; do
  ppinfo " - Install $package"
  npm install -g $package && ppok " - Install $package"
done
unset package{,s}

ppinfo "Post-install npm packages"
for postpackage in ${postpackages[@]}; do
  ppinfo " - Install $postpackage"
  npm install -g $postpackage && ppok " - Install $postpackage"
done
unset postpackage{,s}

ppok " - nvm install complete"
exit 0
