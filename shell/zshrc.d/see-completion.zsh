#!/usr/bin/env zsh
#
# Completion for the 'see' command
# Provides the same autocompletion as 'which' command
#-------------------------------------------------------------------------------

# Define completion function for 'see'
_see() {
  local -a commands aliases functions

  # # Use the same completion as 'which' command
  # _command_names -e

  # Get all commands and executables
  commands=( ${(k)commands} )

  # Get all aliases
  aliases=( ${(k)aliases} )

  # Get all functions
  functions=( ${(k)functions} )

  # Combine and offer as completions
  _alternative \
    'commands:command:compadd -a commands' \
    'aliases:alias:compadd -a aliases' \
    'functions:function:compadd -a functions'
}

# Register the completion function for 'see'
compdef _see see

