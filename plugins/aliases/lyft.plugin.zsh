#!/usr/bin/env zsh
#
# Custom aliases
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# Add zsh help
alias controlstopall="control status | sed '1d' | cut -d' ' -f1 | xargs control stop"
alias enter="control enter mapcurationfe.legacy"
# Some services fail, let's make sure that they start up correctly first
alias ensurepieces="control restart elasticsearch6.server && control ensure -g mapcuration.dev"
# Start up our services
alias ensure="ensurepieces && control ensure -g mapcurationfe.dev"
# Kick off elastic indexing
alias elasticindex="control enter mapcuration.legacy service_venv python manage.py es_etl &"
# Make sure devbox is up-to-date
alias devboxupdate="devbox update"
# Run this at the start of every day
alias lyftstartday="devboxupdate && ensure && elasticindex"
alias monomove="mv /Users/lgordon/lyft/mapcurationfe/node_modules /Users/lgordon/lyft/mapcurationfe/_node_modules"
alias monoreturn="mv /Users/lgordon/lyft/mapcurationfe/_node_modules /Users/lgordon/lyft/mapcurationfe/node_modules"

function lyft_update_npm_alias() {
  local gitroot="$(git rev-parse --show-toplevel)"
  local dest="/srv/service_npm_modules"

  # Ensure that gemfury npm registry has been configured
  [[ -z $(npm -g config list | grep "@lyft:registry") ]] && (
    npm -g config set @lyft:registry https://npm-proxy.fury.io/drM6auMDVB6xY2SH5HWq/lyft/
  )

  # Remove current files and folders in destination. Guard execution
  # errors for first time users of the script.
  ls -l $dest/package*json > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "removing" $dest/package*json
    rm -f $dest/package*json
  fi

  ls -l $dest/*.log > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "removing" $dest/*.log
    rm -f $dest/*.log
  fi

  if [ -d $dest/node_modules ]; then
    echo "removing" $dest/node_modules
    rm -rf $dest/node_modules
  fi

  if [ -d $dest/.git ]; then
    echo "removing" $dest/.git
    rm -rf $dest/.git
  fi

  # Create a git hooks folder in destination for Husky to write to.
  echo "creating" $dest/.git/hooks
  mkdir -p $dest/.git/hooks

  # Copy gitroot package*.json files to destination and run npm ci/install.
  [[ -f $gitroot/package.json ]] && (
    [[ -f $gitroot/.nvmrc ]] && (
      echo "copying .nvmrc"
      cp $gitroot/.nvmrc "$dest"
    )
    [[ -f $gitroot/package.json ]] && (
      echo "copying package.json"
      cp $gitroot/package.json "$dest"
    )
    [[ -f $gitroot/package-lock.json ]] && (
      echo "copying package-lock.json"
      cp $gitroot/package-lock.json "$dest"
    )
    echo "cd to destination"
    cd "$dest"
    echo "change node version"
    nvm use > /dev/null 2>&1
    echo "node version: $(node -v)"
    echo "npm version: $(npm -v)"
    echo "installing dependencies"
    [[ -f $dest/package-lock.json ]] && (
      echo "running npm ci"
      npm ci
    ) || (
      echo "running npm install"
      npm install
    )
    echo "updated $dest"
  )

  # Husky git hooks should now be installed, so copy over the installed
  # git hooks from the destination back to the gitroot git hooks folder.
  ls -l $dest/.git/hooks/* > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "copying git hooks"
    mkdir -p $gitroot/.git/hooks
    cp -f $dest/.git/hooks/* $gitroot/.git/hooks
  fi
}

function lyft_check_talos_containers() {
  # Example output from `control status`
  # dnsmasq.server          ab4771268cb5bce36004e66d90e2329b000dbae5   blacklisted           Up 5 days
  # envoy.server            514f847475c3ce8e274dbd7415e5190ff9f56105   blacklisted           Up 5 days
  # envoymanager.server     3c2080048326a64225c0772f1cbeb546b2292e68   blacklisted           Up 5 days
  # envoystaticconfig.run   d9b1ca41aa8802eb9bb63d786e40b9a00af3cb90                         Up 5 days
  # imageryingest.legacy    8e953b8b4fbc1f3c01a8a6efc7767b18a6b887e3                         Up 5 days
  # images.legacy           835f7f77a2d8db32a482b3963ec719ce325285e9                         Up 5 days
  # mapcuration.legacy      a6e8c1c49a502cd1aea184e0b436384b602de4ce                         Up 5 days
  # mapcurationfe.legacy    9c5179fa1b468d22bcfd84770c5588637165712e   /code/mapcurationfe   Up 55 seconds
  # metadataproxy.server    b09a72e3cc735f38b763c90a1bb76b97126b7f0c                         Up 5 days
  # sqs.server              5ca1ac34ac99f6c5eae1bb6a4d41df8adbac350e   blacklisted           Up 5 days
  # tom.legacy              32f485ada67e1f67d4328505d4152f9164a0be3e                         Up 5 days
}
