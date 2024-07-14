#!/usr/bin/env zsh
#
# Define executable commands that do not change the shell environment.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshenv
#   #!/usr/bin/env zsh
#   zdot load "$ZDOT_SHELL/zprofile.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Load any private environment variables
# ------------------------------------------------------------------------------
zdot load "$ZDOT_ICLOUD_DRIVE/secrets/index.zsh"


# ------------------------------------------------------------------------------
# Setup paths
# ------------------------------------------------------------------------------
zdot load "$ZDOT_SHELL/zpaths.zsh"
