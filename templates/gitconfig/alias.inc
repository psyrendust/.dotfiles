# Git aliases
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------
[alias]
    assume   = update-index --assume-unchanged
    assumed  = "!git ls-files -v | grep ^h | cut -c 3-"
    authors = !git log --all --format='%aN <%aE>' | sort -u
    cp = cherry-pick
    head = "!git rev-parse HEAD | cut -b -7"
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit
    plus = commit -a --amend --no-edit
    root = "!f() { root=$(git rev-parse --git-dir) && root=$(cd \"$root\" && pwd)/ && echo \"${root%%/.git/*}\"; }; f"
    unassume = update-index --no-assume-unchanged
