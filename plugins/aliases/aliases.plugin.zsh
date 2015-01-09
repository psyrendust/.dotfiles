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
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ssh-bouncy="ssh -i ~/.ssh/famous/website.encrypted.pem ec2-user@bouncy-lego-42.phi42.net"
alias server="http-server"
alias npmlist="npm list --depth=0"

function dropshadow() {
  # Turn off dropshadow
  defaults write com.apple.screencapture disable-shadow -bool true && killall SystemUIServer
  # Turn on dropshadow
  # defaults write com.apple.screencapture disable-shadow -bool false && killall SystemUIServer
}
