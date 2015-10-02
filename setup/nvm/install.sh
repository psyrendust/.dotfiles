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

ppinfo "Install nvm"

export NVM_DIR=$HOME/.nvm
[[ -s "$(brew --prefix nvm)/nvm.sh" ]] && source $(brew --prefix nvm)/nvm.sh

ppinfo " - Check for nvm"
if test ! $(nvm --version)
then
  ppinfo " - Installing nvm"
  curl https://raw.githubusercontent.com/creationix/nvm/v0.22.0/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" # This loads nvm"

ppinfo " - Install latest stable NodeJS"
nvm install stable

ppinfo " - Set the latest stable NodeJS to default"
nvm alias default stable

ppinfo " - Set npm loglevel to http"
npm config set loglevel http

packages=(
  npm
  babel
  bower
  david
  eslint
  forever
  grunt-cli
  grunt-init
  gulp
  http-server
  jscs
  jshint
  jspm
  live-server
  lorem-ipsum
  nodemon
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
