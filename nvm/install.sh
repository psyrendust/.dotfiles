#!/usr/bin/env bash
#
# Install nvm, NodeJS, and npm
#
# This installs some of the common dependencies needed (or at least desired)
# using NodeJS.

ppinfo 'Install nvm'
ppinfo ' - Check for nvm'
if test ! $(which nvm)
then
  ppinfo " - Installing nvm"
  curl https://raw.githubusercontent.com/creationix/nvm/v0.22.0/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" # This loads nvm"

ppinfo ' - Install latest stable NodeJS'
nvm install stable

ppinfo ' - Set the latest stable NodeJS to default'
nvm alias default stable

packages=(
  npm
  eslint
  express-generator
  famous-dist-generator
  forever
  grunt-cli
  grunt-init
  gulp
  http-server
  jscs
  jshint
  jspm
  nodemon
  npm-check-updates
)

ppinfo "Install npm packages"
for package in ${packages[@]}; do
  ppinfo " - Install $package"
  npm install -g $package && ppok " - Install $package"
done
unset package{,s}

ppok ' - nvm install complete'
exit 0
