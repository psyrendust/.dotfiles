#!/usr/bin/env zsh
#
# Custom tomorrow-theme config for bat
#
# @see https://github.com/sharkdp/bat#adding-new-themes
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------


### Initialize theme paths
# ------------------------------------------------------------------------------
BAT_TOMORROW_THEME_SRC="$ANTIDOTE_HOME/chriskempson/tomorrow-theme/textmate"
BAT_CONFIG_TOMORROW_THEME="$(bat --config-dir)/themes/tomorrow-theme"

# Only run if the source directory exists
# ------------------------------------------------------------------------------
if [[ -d "$BAT_TOMORROW_THEME_SRC" ]]; then

  # Ensure the BAT config theme directory exists
  if [[ ! -d "$BAT_CONFIG_TOMORROW_THEME" ]]; then
    mkdir -p "$BAT_CONFIG_TOMORROW_THEME"

    # Copy files from the source directory to the destination directory
    cp -r "$BAT_TOMORROW_THEME_SRC"/*.tmTheme "$BAT_CONFIG_TOMORROW_THEME"

    # Rebuild the bat cache
    bat cache --build
  fi

fi

bat-tomorrow-theme_plugin_unload() {
  # Remove all files from the destination directory
  rm -rf "$BAT_CONFIG_TOMORROW_THEME"

  # Rebuild the bat cache
  bat cache --build
}
