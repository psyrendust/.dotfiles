#!/usr/bin/env zsh
#
# Define aliases, functions, shell options, and key bindings.
#
# Authors:
#   Larry Gordon
#
# Usage: save to ~/.zshrc
#   #!/usr/bin/env zsh
#   zdot load "$ZDOT_TEMPLATES/zshrc.zsh"
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/templates/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Load framework
# ------------------------------------------------------------------------------
# zdot load "$ZDOT_TEMPLATES/zshrc-zinit.zsh"
zdot load "$ZDOT_TEMPLATES/zshrc-zplug.zsh"

# ------------------------------------------------------------------------------
# Load nvm
# ------------------------------------------------------------------------------
zdot load "$ZDOT_TEMPLATES/init_nvm"
