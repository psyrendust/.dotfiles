# Configure git to use Kaleidoscope for diff and merges
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------
[diff]
    tool = Kaleidoscope
[merge]
    tool = Kaleidoscope


# Configure ksdiff to handle a 3-way diff and merge for Kaleidoscope
# ------------------------------------------------------------------------------
[difftool "Kaleidoscope"]
    cmd = ksdiff --partial-changeset --relative-path \"$MERGED\" -- \"$LOCAL\" \"$REMOTE\"
[mergetool "Kaleidoscope"]
    cmd = ksdiff --merge --output \"$MERGED\" --base \"$BASE\" -- \"$LOCAL\" --snapshot \"$REMOTE\" --snapshot
