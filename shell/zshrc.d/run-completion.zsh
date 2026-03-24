#compdef run
#
# Completion function for run command
# Delegates to the appropriate package manager's completion for "run" subcommand
#-------------------------------------------------------------------------------

# Define completion function for 'run'
_run() {
  local package_manager="$(ywhich)"

  # If we found a package manager, delegate to its completion function
  if [[ -n "$package_manager" ]]; then
    # Build new words array: <package_manager> run <original_args>
    local -a new_words
    new_words=($package_manager run "${words[@]:1}")

    # Replace words array
    words=("${new_words[@]}")

    # Adjust CURRENT to account for the injected "run" (position 2)
    (( CURRENT += 1 ))

    # Call the appropriate completion function
    case $package_manager in
      yarn)
        _yarn
        ;;
      npm)
        _npm
        ;;
      pnpm)
        _pnpm
        ;;
      bun)
        _bun
        ;;
    esac
  fi
}

# Register the completion function for 'run'
compdef _run run
