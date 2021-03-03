#!/usr/bin/env zsh
#
# Custom git-fuzzy config
#
# @see https://github.com/bigH/git-fuzzy
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------

# Keyboard Shortcuts: Git Stash
export GIT_FUZZY_DROP_KEY="D"

# Keyboard Shortcuts: Git Status
export GIT_FUZZY_STATUS_ADD_KEY="A"
export GIT_FUZZY_STATUS_EDIT_KEY="E"
export GIT_FUZZY_STATUS_COMMIT_KEY="C"
export GIT_FUZZY_STATUS_RESET_KEY="R"
export GIT_FUZZY_STATUS_DISCARD_KEY="D"

# Keyboard Shortcuts: Git Status
export GIT_FUZZY_BRANCH_WORKING_COPY_KEY="Ctrl-P"
export GIT_FUZZY_BRANCH_MERGE_BASE_KEY="Alt-P"
export GIT_FUZZY_BRANCH_COMMIT_LOG_KEY="Alt-L"
export GIT_FUZZY_BRANCH_CHECKOUT_FILE_KEY="Alt-F"
export GIT_FUZZY_BRANCH_CHECKOUT_KEY="Alt-B"
export GIT_FUZZY_BRANCH_DELETE_BRANCH_KEY="Alt-D"

alias gf="git fuzzy"
alias gfb="git fuzzy branch"
alias gfs="git fuzzy status"
alias gfstash="git fuzzy stash"
