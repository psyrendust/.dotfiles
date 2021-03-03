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

# Create an associative array for {key:value} pairs
# @see https://scriptingosx.com/2019/11/associative-arrays-in-zsh/
declare -A brew_formulas

# key: location
# val: formula name
# Regular bash executables
brew_formulas=(
    ["/usr/local/bin/bash"]="bash"
    ["/usr/local/bin/bat"]="bat"
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
brew_formulas+=(
    ["/Applications/Apparency.app"]="apparency"
    ["$HOME/Library/QuickLook/QLColorCode.qlgenerator"]="qlcolorcode"
    ["$HOME/Library/QuickLook/qlImageSize.qlgenerator"]="qlimagesize"
    ["$HOME/Library/QuickLook/QLMarkdown.qlgenerator"]="qlmarkdown"
    ["$HOME/Library/QuickLook/QLStephen.qlgenerator"]="qlstephen"
    ["/Library/QuickLook/Video.qlgenerator"]="qlvideo"
    ["$HOME/Library/QuickLook/QuickLookJSON.qlgenerator"]="quicklook-json"
    ["$HOME/Library/QuickLook/QuickLookASE.qlgenerator"]="quicklookase"
    ["/Applications/Suspicious Package.app"]="suspicious-package"
)

# echo `realpath $0`
# echo ${(kv)brew_formulas}

local brew_formulas_missing=()

# Check for missing formulas
for key value in ${(kv)brew_formulas}; do
    [[ -a "$key" ]] || brew_formulas_missing+=("$value")
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
