# OS X Git configuration to use vscode for diff and merges
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------
[diff]
    tool = code
[merge]
    tool = code


# Configure code to handle diff and merge
#   -d --diff <file1> <file2>                     Compare two files with each other.
#   -m --merge <file1> <file1> <base> <result>    Perform a three-way merge by providing paths for
#                                                 two modified versions of a file, the common origin
#                                                 of both modified versions, and the output file to
#                                                 save merge results.
#   -n --new-window                               Force to open a new window.
#   -w --wait                                     Wait for the files to be closed before returning.
# ------------------------------------------------------------------------------
[difftool "code"]
    cmd = code --wait --diff $LOCAL $REMOTE
[mergetool "code"]
    # 3-way merge
    cmd = code --wait --merge $REMOTE $LOCAL $BASE $MERGED
