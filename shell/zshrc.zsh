#!/usr/bin/env zsh
#
# Define aliases, functions, shell options, and key bindings.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshrc
#   #!/usr/bin/env zsh
#   zdot load "$ZDOT_SHELL/zshrc.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Load framework
# ------------------------------------------------------------------------------
# zdot load "$ZDOT_SHELL/zshrc-zinit.zsh"
zdot load "$ZDOT_SHELL/zshrc-zplug.zsh"

# ------------------------------------------------------------------------------
# Load nvm
# ------------------------------------------------------------------------------
zdot load "$ZDOT_SHELL/init_nvm"
