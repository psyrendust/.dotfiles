# beads.zsh — automatically resolve and export BEADS_DIR for git worktrees
#
# When inside a git worktree or project checkout, bd may fail to resolve
# the database if a primary checkout's `.git` directory halts the parent walk.
# This hook inspects parent directories for a `.beads` directory and exports
# BEADS_DIR, unsetting it when leaving.

_beads_dir_sync() {
	emulate -L zsh
	local dir=$PWD
	local found=""

	# Walk upward until hitting / or $HOME
	while [[ $dir != "/" && $dir != "$HOME" ]]; do
		if [[ -d "$dir/.beads" ]]; then
			found="$dir/.beads"
			break
		fi
		dir=${dir:h}
	done

	if [[ -n $found ]]; then
		if [[ $BEADS_DIR != "$found" ]]; then
			export BEADS_DIR="$found"
		fi
	else
		if [[ -n $BEADS_DIR ]]; then
			unset BEADS_DIR
		fi
	fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _beads_dir_sync
_beads_dir_sync # Seed current shell
