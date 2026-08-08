#!/usr/bin/env zsh
#
# Tree-scoped package registry.
#
# npm, pnpm, bun and yarn all read a project `.npmrc` from the directory they are
# invoked in and NONE of them walk up the tree. So a `.npmrc` at the root of a
# tree governs that root only, and every repo beneath it silently falls back to
# whatever the user-level config says. This hook does the walk that the tools
# won't and publishes the answer through environment variables, so one `.npmrc`
# at the top of a tree governs everything under it, in every tool.
#
# This replaces flipping a global `~/.npmrc` symlink between profiles. That
# approach stored a per-directory fact in one machine-wide mutable location: it
# only updated when a wrapper command happened to run, concurrent shells in
# different trees fought over it, and anything spawned outside those wrappers
# (editors, agents, CI shims) inherited whichever profile was selected last.
# Environment state is per-process, so it cannot be raced that way.
#
# `$HOME/.npmrc` is deliberately NOT consulted: that is npm's own user-level
# config and every tool already applies it. This hook supplies only what the
# tools cannot see for themselves, which also caps the walk at $HOME.
#
# Measured tool support (2026-08, npm 10.9 / pnpm 9.15 / bun 1.3.14 / yarn 4.17):
#   npm, pnpm, bun -> `npm_config_registry`
#   yarn (berry)   -> `YARN_NPM_REGISTRY_SERVER`; it IGNORES npm_config_registry
#                     and otherwise defaults to registry.yarnpkg.com
#   pnpm has no registry variable of its own: both `pnpm_config_registry` and
#   `PNPM_CONFIG_REGISTRY` are ignored, so npm_config_registry is the only lever.
#   bun also honors `BUN_CONFIG_REGISTRY`, which npm_config_registry makes moot.
#
# Cost per `cd`: nothing at all when the directory is unchanged or already seen,
# otherwise one stat per level up to $HOME (typically 2-5) and a builtin read of
# the first `.npmrc` found. No subshells, no forks, no external commands.

typeset -gA _npm_registry_memo   # directory -> registry, or "-" for none
typeset -g  _npm_registry_pwd=   # directory the current env vars were resolved for


# Walk up from $1 and return the nearest declared registry in REPLY ("" if none).
_npm_registry_resolve() {
	local dir=$1
	local -a lines match
	REPLY=
	while [[ $dir == /* && $dir != / && $dir != $HOME ]]; do
		if [[ -r $dir/.npmrc ]]; then
			# One builtin file read plus one array filter — no forks, and ~3x
			# faster than a per-line `read` loop. Whitespace is stripped wholesale
			# because a registry URL cannot contain any, which also avoids needing
			# `extended_glob` just to trim. Patterns are anchored, so `#registry=`,
			# `;registry=` and `@scope:registry=` are all correctly ignored.
			lines=( ${${(f)"$(<$dir/.npmrc)"}//[[:space:]]/} )
			match=( ${(M)lines:#registry=?*} )
			if (( $#match )); then
				REPLY=${match[-1]#registry=}   # last wins, as npm's ini parser does
				return 0
			fi
		fi
		dir=${dir:h}
	done
	return 0
}

_npm_registry_sync() {
	# Unchanged directory cannot change the answer.
	[[ $PWD == $_npm_registry_pwd ]] && return 0
	_npm_registry_pwd=$PWD

	# "-" is the not-found sentinel, so an empty slot means "never resolved" and
	# no separate key-existence test is needed.
	local reg=${_npm_registry_memo[$PWD]}
	if [[ -z $reg ]]; then
		_npm_registry_resolve $PWD
		reg=${REPLY:--}
		_npm_registry_memo[$PWD]=$reg
	fi
	[[ $reg == - ]] && reg=

	# Only touch the environment when the effective registry actually changes.
	[[ $reg == ${npm_config_registry-} ]] && return 0
	if [[ -n $reg ]]; then
		export npm_config_registry=$reg YARN_NPM_REGISTRY_SERVER=$reg
	else
		unset npm_config_registry YARN_NPM_REGISTRY_SERVER
	fi
	return 0
}

# Report the effective registry and where it came from; `-r` rebuilds the cache
# after a `.npmrc` is added or edited (the cache is per-shell and never expires).
npm-registry() {
	emulate -L zsh
	if [[ $1 == (-r|--refresh) ]]; then
		_npm_registry_memo=()
		_npm_registry_pwd=
		_npm_registry_sync
	fi
	local dir=$PWD src=
	while [[ $dir == /* && $dir != / && $dir != $HOME ]]; do
		[[ -r $dir/.npmrc ]] && { _npm_registry_resolve $dir; [[ -n $REPLY ]] && { src=$dir/.npmrc; break } }
		dir=${dir:h}
	done
	print -r -- "registry: ${npm_config_registry:-https://registry.npmjs.org (built-in default)}"
	print -r -- "source:   ${src:-none above \$HOME; ~/.npmrc and tool defaults apply}"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _npm_registry_sync
_npm_registry_sync   # seed this shell
