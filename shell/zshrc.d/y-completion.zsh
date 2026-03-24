#compdef y
#
# Completion function for y command
# Delegates to the appropriate package manager's completion
#-------------------------------------------------------------------------------
_y() {
  local package_manager="$(ywhich)"

  # If we found a package manager, delegate to its completion function
  if [[ -n "$package_manager" ]]; then
    # Temporarily replace the command name for completion
    words[1]=$package_manager

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

# Register the completion function for 'y'
compdef _y y
