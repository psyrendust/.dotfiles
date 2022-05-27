#!/usr/bin/env zsh
#
# Check for brew formulas that have not been installed
#
# Authors:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

mkdir -p "$ZDOT_CACHE"
# local DEBUG=true

log() {
  if [[ -n $DEBUG ]]; then
    echo $@
  fi
}

# Create an associative array for {key:value} pairs
# @see https://scriptingosx.com/2019/11/associative-arrays-in-zsh/
declare -A brew_formulas
declare -A brew_formula_apps

# key: location
# val: formula name
# Regular bash executables
brew_formulas=(
  ["/usr/local/bin/bash"]="bash"
  ["/usr/local/bin/bat"]="bat"
  ["/usr/local/bin/batman"]="eth-p/software/bat-extras"
  ["/usr/local/bin/diff-so-fancy"]="diff-so-fancy"
  ["/usr/local/bin/exa"]="exa"
  ["/usr/local/bin/fasd"]="fasd"
  ["/usr/local/bin/fd"]="fd"
  ["/usr/local/bin/fzf"]="fzf"
  ["/usr/local/bin/git"]="git"
  ["/usr/local/bin/git-recent"]="git-recent"
  ["/usr/local/bin/pygmentize"]="pygments"
  ["/usr/local/bin/rg"]="ripgrep"
  ["/usr/local/bin/tree"]="tree"
  ["/usr/local/bin/zsh"]="zsh"
)
# Quicklook plugins
# @see https://github.com/sindresorhus/quick-look-plugins#install-all
brew_formula_apps=(
  ["/Applications/QLMarkdown.app"]="sbarex-qlmarkdown"
  ["/Applications/Syntax Highlight.app"]="syntax-highlight"
  ["$HOME/Library/QuickLook/QLStephen.qlgenerator"]="qlstephen"
  ["/Applications/Suspicious Package.app"]="suspicious-package"
)
brew_formulas+=(${(kv)brew_formula_apps})

log "brew_formulas:"
log ${(kv)brew_formulas}""
log ""

local brew_formulas_missing=()
local cleanup_attributes=()

# Check for missing formulas
for key value in ${(kv)brew_formulas}; do
  log "[$key] - [$value]"
  if [[ ! -a "$key" ]]; then
    log "-- missing $key"
    brew_formulas_missing+=("$value")
    if [[ -n $(echo "${(v)brew_formula_apps}" | grep "$value") ]]; then
      log "---- is Application $key"
      cleanup_attributes+=("$key")
    fi
  fi
done

log ""
log "missing formulas:"
for value in ${brew_formulas_missing[@]}; do
  log "- $value"
done

# Report missing formulas and ask if we should install them
if [[ ! ${#brew_formulas_missing[@]} -eq 0 ]]; then
  printf "\033[0;31mMissing homebrew formulas:\033[0m\n"
  printf --  \
    "- \033[0;31m%s\033[0m: not installed\n" \
    "${brew_formulas_missing[@]}"
  printf "Install? [y/N]: "
  if read -q; then
    echo;
    brew install ${brew_formulas_missing[@]}
  fi
  echo;
fi

# Cleanup quarantine attributes
log ""
log "cleanup attributes:"
for key in ${cleanup_attributes[@]}; do
  log "[$key]"
  xattr -r -d com.apple.quarantine "$key"
done
