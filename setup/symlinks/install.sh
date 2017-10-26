#!/usr/bin/env zsh
#
# Setup symlinks
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

ppinfo "Setup Symlinks"

path_dotfiles="${HOME}/.dotfiles"
path_app_support="${HOME}/Library/Application Support"
path_dropbox="${HOME}/Dropbox/Larry"

# Create hash of <source> <destination> paths
zstyle ':symlink:paths' paths \
  '${path_dotfiles}/.editorconfig' '${HOME}/.editorconfig' \
  '${path_dropbox}/_mackup/Library/Application Support/Sublime Text 3/Packages/User/node_env.py' '${path_app_support}/Sublime Text 3/Packages/node_env.py'
  # '${path_dropbox}/_mackup/Library/Application Support/Sublime Text 3/Packages/User' '${path_app_support}/Sublime Text 3/Packages/User' \


# Create a hash
typeset -A symlink_paths
# Expand paths into hash
zstyle -a ':symlink:paths' paths 'symlink_paths'

# Iterate over hash
for symlink_path in "${(k)symlink_paths[@]}"; do
  symlink_source="`eval echo "$symlink_path"`"
  symlink_dest="`eval echo "$symlink_paths[$symlink_path]"`"

  # If it's a symlink, then delete it
  if [[ -h "$symlink_dest" ]]; then
    ppemph " - found symlink (removing): $symlink_dest"
    eval "rm \"$symlink_dest\""

  # if it's a folder or a regular file, then move it
  elif [[ -d "$symlink_dest" ]] || [[ -f "$symlink_dest" ]]; then
    backup="`dirname $symlink_dest`/_`basename $symlink_dest`";
    ppwarn " - destination exists (backup created): $backup"
    eval "mv \"$symlink_dest\" \"$backup\""
  fi

  # Create a new symlink
  ppinfo " - create symlink:"
  ppinfo "   - from: "$symlink_source""
  ppinfo "   -   to: $symlink_dest"
  ln -sf "$symlink_source" "$symlink_dest"
done


ppok " - Symlinks setup complete"
# exit 0
