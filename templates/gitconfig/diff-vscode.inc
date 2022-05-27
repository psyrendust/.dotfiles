# Configure git to use vscode for diff and merges
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------
[diff]
    tool = vscode
[merge]
    tool = vscode


# Configure vscode to handle diff and merge
#   -n --new-window                   Force to open a new window.
#   -w --wait                         Wait for the files to be closed before returning.
#   -d --diff <file> <file>           Compare two files with each other.
# ------------------------------------------------------------------------------
[difftool "vscode"]
    cmd = code -nwd $LOCAL $REMOTE
[mergetool "vscode"]
    cmd = code -nw $MERGED
