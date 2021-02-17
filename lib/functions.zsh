# Load all the config files in oh-my-zsh that end in .zsh
# Load this file as an empty override, because we don't
# want to load it

function zsh_stats() {
  fc -l 1 \
    | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
    | grep -v "./" | sort -nr | head -n20 | column -c3 -s " " -t | nl
}

function take() {
  mkdir -p $@ && cd ${@:$#}
}