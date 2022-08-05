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
    # List files which have changed since REVIEW_BASE
    files = !git diff --name-only $(git review-base)
    head = "!git rev-parse HEAD | cut -b -7"
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit
    # Show just the subject and body of a particular commit (default: HEAD)
    message = log -n1 --format=\"%s%n%n%b\"
    plus = commit -a --amend --no-edit
    # Show a markdown-formatted summary of commits from {REVIEW_BASE:-origin/master} until HEAD
    pr-summary = !git log --reverse --format=\"- **%s** (%h)%n%n%w(74,2,2)%b\" \"${REVIEW_BASE:-origin/master}\"..HEAD
    # The SHA to compare diffs against
    review-base = !git merge-base HEAD \"${REVIEW_BASE:-origin/master}\"
    root = "!f() { root=$(git rev-parse --git-dir) && root=$(cd \"$root\" && pwd)/ && echo \"${root%%/.git/*}\"; }; f"
    # Same as above, but with a diff stat instead of just names (better for interactive use)
    stat = !git diff --stat $(git review-base)
    unassume = update-index --no-assume-unchanged
