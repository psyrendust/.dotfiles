#!/usr/bin/env zsh
#
# Define path locations.
#
# Authors:
#   Larry Gordon
#
# Usage: loaded by $ZDOT_SHELL/zprofile.zsh
#
# Execution Order
#   https://github.com/psyrendust/.dotfiles/blob/master/shell/README.md#for-zsh
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2021/license.html>
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Setup paths
# ------------------------------------------------------------------------------
typeset -a __path_pre __path_post


# Paths for installed tools
[[ -d "$HOME/.local/bin" ]] && __path_pre+=("$HOME/.local/bin")


# Custom path locations for my plugins
__path_pre+=("$ZDOT_PLUGINS/asciinema2gif/bin")
__path_pre+=("$ZDOT_PLUGINS/changecase/bin")
__path_pre+=("$ZDOT_PLUGINS/pretty-print/bin")
__path_pre+=("$ZDOT_PLUGINS/npmlist/bin")
__path_pre+=("$ZDOT_PLUGINS/textcleaner/bin")
__path_pre+=("$ZDOT_PLUGINS/iterm2/bin")
__path_pre+=("$ZDOT_PLUGINS/vscode/bin")
__path_pre+=("$ZDOT_DROPBOX_BIN")
__path_pre+=("$ZDOT_BIN")
__path_pre+=("$HOME/.tmpbin")


# Custom path locations for my work plugins
[[ -d "$ZDOT_WORK_BIN" ]] && __path_pre+=("$ZDOT_WORK_BIN")


# Add Bun
[[ -n "$BUN_INSTALL" && -d "$BUN_INSTALL/bin" ]] && __path_pre+=("$BUN_INSTALL/bin")
# Add LM Studio CLI (lms)
[[ -d "$HOME/.lmstudio/bin" ]] && __path_pre+=("$HOME/.lmstudio/bin")
# Add Claude Code bin
[[ -d "$CLAUDE_BIN" ]] && __path_pre+=("$CLAUDE_BIN")


# Add GOPATH and GOROOT
[[ -d "$GOPATH" ]] && [[ -d "$GOPATH/bin" ]] && __path_pre+=("$GOPATH/bin")
[[ -d "$GOROOT" ]] && [[ -d "$GOROOT/bin" ]] && __path_pre+=("$GOROOT/bin")

# Add coreutils bin
[[ :$PATH: != *:"$ZDOT_BREW_ROOT/opt/coreutils/libexec/gnubin":* ]] && __path_pre+=("$ZDOT_BREW_ROOT/opt/coreutils/libexec/gnubin")


# ------------------------------------------------------------------------------
# Add homebrews paths with `brew shellenv`, evals the following
# ------------------------------------------------------------------------------
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
fpath[1,0]="/opt/homebrew/share/zsh/site-functions";
export FPATH;
eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";


# ------------------------------------------------------------------------------
# Add pyenv path with `pyenv init -`
# @see https://opensource.com/article/19/5/python-3-default-mac#what-we-should-do
# ------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  # using manual execution instead of doing eval
  # eval $(pyenv init -)
  # skip removing .pyenv/shims from path
  # PATH="$(bash --norc -ec 'IFS=:; paths=($PATH);
  # for i in ${!paths[@]}; do
  # if [[ ${paths[i]} == "''/Users/larrygordon/.pyenv/shims''" ]]; then unset '\''paths[i]'\'';
  # fi; done;
  # echo "${paths[*]}"')"
  export PATH="/Users/larrygordon/.pyenv/shims:${PATH}"
  export PYENV_SHELL=zsh
  # version numbers change so use a glob pattern to get the correct version;
  # (N) = expand to nothing (no error) if absent, n = numeric sort so the
  # highest version is last
  __pyenv_completions=(/opt/homebrew/Cellar/pyenv/*/completions/pyenv.zsh(Nn))
  (( $#__pyenv_completions )) && source "${__pyenv_completions[-1]}"
  unset __pyenv_completions
  # don't run rehash at startup see __pyenv_pip below
  # command pyenv rehash
  pyenv() {
    local command=${1:-}
    [ "$#" -gt 0 ] && shift
    case "$command" in
    activate|deactivate|rehash|shell)
      eval "$(pyenv "sh-$command" "$@")"
      ;;
    *)
      command pyenv "$command" "$@"
      ;;
    esac
  }
  # Auto-rehash after `pip (un)install` so new console-scripts get shims
  # without a manual `pyenv rehash`. Routes through the `pyenv rehash` function
  # above, which also runs `hash -r` so the new command is usable immediately
  # in this same shell. The subcommand is found by skipping any leading flags.
  __pyenv_pip() {
    local bin=$1; shift
    command "$bin" "$@"
    local ret=$? arg
    for arg in "$@"; do
      case "$arg" in
        -*) continue ;;
        install|uninstall) pyenv rehash; break ;;
        *) break ;;
      esac
    done
    return $ret
  }
  pip()  { __pyenv_pip pip  "$@" }
  pip3() { __pyenv_pip pip3 "$@" }
fi


# ------------------------------------------------------------------------------
# Apply PATHS
# ------------------------------------------------------------------------------
export PATH="$([[ ${#__path_pre} > 0 ]] && printf "%s:" "${__path_pre[@]}")$PATH$([[ ${#__path_post} > 0 ]] && printf ":%s" "${__path_post[@]}")"

unset __path_pre
unset __path_post
