#!/usr/bin/env zsh
#
# Custom git aliases
#
# Author:
#   Larry Gordon
#
# License:
#   The MIT License (MIT) <http://psyrendust.mit-license.org/2014/license.html>
# ------------------------------------------------------------------------------
function _current_branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

function _git-branch-from-here() {
  git checkout -b $@ $(current_branch)
}

function _git-branch-delete-grep() {
  while getopts ":s" opt; do
    [[ $opt == "s" ]] && has_option=1
  done
  if [[ -n $has_option ]]; then
    shift
    for branch in $(git branch | egrep "^[ ]+$@" | sed -e 's/ //g' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"); do
      git branch -D $branch
    done
  else
    git branch -D $@
  fi
}

# git checkout remote branch and track it
function _git-checkout-branch() {
  if [[ "$#" -ne 2 ]]; then
    git checkout -b $1 origin/$1
  else
    git checkout -b $2 $1/$2
  fi
}

# git clone and cd into directory
function _git-clone-cd() {
  if [[ "$#" -ne 2 ]]; then
    repourl="$1"
    repodir="${$(echo ${repourl##*/})%.git}"
  else
    repourl="$1"
    repodir="$2"
  fi
  git clone ${repourl} ${repodir} && cd ${repodir}
}

function _git-rebase-origin() {
  local branch_name=${1:-$(current_branch)}
  git rebase origin/${branch_name}
}

# update target branch and merge it into current branch
function _git-merge-from() {
  current_branch=$(current_branch)
  target_branch=$1
  echo "switching to branch $target_branch"
  gco -f $target_branch
  echo "updating branch $target_branch"
  ggpur
  echo "switching to branch $current_branch"
  gco -f $current_branch
  echo "stashing any changes"
  gsdel
  echo "merging $target_branch into $current_branch"
  git merge $target_branch
}

# update branch from origin and merge it into current branch
function _git-merge-from-origin() {
  current_branch=$(current_branch)
  echo "fetching from origin $1"
  gfo $1:$1
  echo "merging origin $1 into $current_branch"
  git merge $1
}

# update branch from upstream and merge it into current branch
function _git-merge-from-upstream() {
  current_branch=$(current_branch)
  echo "fetching from upstream $1"
  gfu $1:$1
  echo "merging upstream $1 into $current_branch"
  git merge $1
}

# update branch from root and merge it into current branch
function _git-merge-from-root() {
  current_branch=$(current_branch)
  echo "fetching from upstream $1"
  gfr $1:$1
  echo "merging root $1 into $current_branch"
  git merge $1
}

# clean up and remove any *.orig files created from a merge conflict
function _git-merge-clean() {
  find $(git rev-parse --show-toplevel) -type f -name \*.orig -exec rm -f {} \;
}

# github broke some workflow... this will make it less painful
# function _git-patchit() {
#   TOKEN="$CONVENTIONAL_GITHUB_RELEASER_TOKEN"
#   FILE="$(echo "$1.patch" | sed s_pull/[0-9]*/commits_commit_)"
#   echo "$FILE"

#   curl --header 'Authorization: token $TOKEN' \
#        --header 'Accept: application/vnd.github.v3.raw' \
#        --remote-name \
#        --progress-bar \
#        --location-trusted "$FILE"
#   #      --location $FILE | git am --whitespace=fix;
# }
# patchit = "!f() { curl -L $1.patch | git am --whitespace=fix; }; f"
# patchit-please = "!f() { echo $1.patch | sed s_pull/[0-9]*/commits_commit_ | xargs curl -L | git am -3 --whitespace=fix; }; f"
# patchit-please = "!f() { curl -L $1.patch | git am -3 --whitespace=fix; }; f"

function patchit() {
  local currBranch="$(current_branch)";
  local destBranch="develop";
  local tempBranch="staging";
  local patchFile=".git/patches/$currBranch.patch";

  mkdir -p ".git/patches"

  # Make sure we are up to date
  git checkout "$destBranch";
  git pull --rebase origin $destBranch;

  # Make a staging branch from develop
  git checkout -b "$tempBranch" "$destBranch";

  # Create the patch
  git checkout "$currBranch";
  git format-patch "$tempBranch" --stdout > "$patchFile";

  # Switch to staging branch
  git checkout "$tempBranch";

  # Stat the patch
  git apply --stat "$patchFile";

  echo "Would you like to continue?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done

  # Check the patch
  git apply --check "$patchFile";

  echo "Would you like to continue?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done

  # Apply the patch
  git am -3 --whitespace=fix --signoff < "$patchFile";
}

function patchmerge() {
  git checkout develop # Switch to develop branch
  git rebase staging # Rebase the changes from staging into develop
  git branch -D staging # Delete the staging branch
  rm .git/*.patch # Remove any .patch files
}

# create a stash and delete it
function _git-stash-delete() {
  # Let's make sure there is something to stash
  command git diff --quiet --ignore-submodules HEAD &>/dev/null;
  (($? == 1)) && git stash save && git stash drop stash@{0};
}

# remove everything from the index and then write both the index and the
# working directory from git's database.
function _git-clean-index() {
  echo "Working, please be patient..."
  local current_location=$PWD
  if [ $# -eq 0 ]; then
    cd $(git rev-parse --show-toplevel)
  else
    cd $1
  fi
  git rm --cached -r .
  git clean -fdx
  git reset HEAD --hard
  git add .
  cd "$current_location"
}

# Output multiline commit messages that contain subject/body/footer
function _git-log-pretty-full() {
  git log --format="%C(yellow)- %h%Creset %Cgreen%B%Creset"
}

function _git-log-pretty-grep() {
  git log --pretty=format:'%s' -i --grep='$(1)'
}

function _git-log-pretty-grep-begin() {
  git log --pretty=format:'%s' -i --grep='^$1'
}

function _git-log-pretty-grep-begin-sublime() {
  git log --pretty=format:'%s' -i --grep='^$1'
}

# Workaround for fmt-merge-msg issue on Mavericks w/SMB repo
# gfm [<remote>] [<remote branch>]
function _git-fetch-merge() {
  local remote="$1"
  local branch="$2"
  local tmp_branch="${2}_merge_tmp"
  git fetch $remote $branch:$tmp_branch
  git merge $tmp_branch
  git branch -D $tmp_branch
}

# Generates git changelog grouped by day
#
# optional parameters
# -a, --author       to filter by author
# -s, --since        to select start date
# -u, --until        to select end date
function git-log-by-day () {
  NEXT=$(date +%F)
  echo "CHANGELOG"
  echo ----------------------
  git log --no-merges --format="%cd" --date=short | sort -u -r | while read DATE ; do
      echo
      echo [$DATE]
      GIT_PAGER=cat git log --no-merges --format=" * %s" --since=$DATE --until=$NEXT
      NEXT=$DATE
  done
}

function gitfixtag() {
  local tag="$1"
  git checkout $tag
  git tag -d $tag
  git push origin :refs/tags/$tag
  GIT_COMMITTER_DATE="$(git show --format=%aD | head -1)" git tag -a $tag -m "$tag"
  git push --tags
}

alias gfm="_git-fetch-merge"

alias gaa='git add -A'
compdef _git gaa=git-add

alias gass='git update-index --assume-unchanged'
compdef _git gass=git-update-index

alias gbdel='git branch -D'
compdef _git gbdel=git-branch

alias gbdelgrep='_git-branch-delete-grep'
compdef _git gbdel=git-branch

alias gbfromhere='_git-branch-from-here'
compdef _git gbromhere=git-checkout

alias gcd='_git-clone-cd'
compdef _git gcd=git-clone

alias gcleanindex='_git-clean-index'
compdef _git gcleanindex=git-rm

alias gcob='_git-checkout-branch'
compdef _git gcob=git-checkout

alias gcobu='_git-checkout-branch upstream'
compdef _git gcob=git-checkout

alias gconflicts="grep -lr --exclude-dir="node_modules" '<<<<<<<' ."

alias gcundo='git reset --soft HEAD~1'
compdef _git gcundo=git-reset

alias gcunstage='git reset HEAD~1'
compdef _git gcunstage=git-reset

alias gcreset='gcundo && gcunstage && grhh'
compdef _git gcreset=git-reset

alias gfffinish='git flow feature finish -r'
compdef _git gfffinish=git-flow-feature-finish

alias gffstart='git flow feature start'
compdef _git gffstart=git-flow-feature-start

alias gfhfinish='git flow hotfix finish -r'
compdef _git gfhfinish=git-flow-hotfix-finish

alias gfhstart='git flow hotfix start'
compdef _git gfhstart=git-flow-hotfix-start

alias gfo='git fetch origin'
compdef _git gfo=git-fetch

alias gfr='git fetch root'
compdef _git gfr=git-fetch

alias gfrfinish='git flow release finish -r'
compdef _git flowrf=git-flow-release-finish

alias gfrstart='git flow release start'
compdef _git gfrstart=git-flow-release-start

alias gfu='git fetch upstream'
compdef _git gfu=git-fetch

alias grbo='_git-rebase-origin'
compdef _git grbo=git-rebase

alias ggpullu='git pull upstream $(current_branch)'
compdef _git ggpullu=git-pull

alias ggpullr='git pull --rebase origin $(current_branch)'
compdef _git ggpullr=git-pull

alias ggpullru='git pull --rebase upstream $(current_branch)'
compdef _git ggpullru=git-pull

alias ggpusha='git push origin master && git push origin develop && git push --tags'
compdef _git ggpusha=git-push

alias ggpushu='git push upstream $(current_branch)'
compdef _git ggpushu=git-push

alias gl='_git-log-pretty-grep'
compdef _git glg=git-log

alias glb='_git-log-pretty-grep-begin'
compdef _git glg=git-log

alias glf='_git-log-pretty-full'
compdef _git glg=git-log

alias gls='_git-log-pretty-grep-begin-sublime'
compdef _git glg=git-log

alias gm='git merge'
compdef _git gm=git-merge

alias gmclean='_git-merge-clean'
compdef _git gmclean=git-rm

alias gmfrom='_git-merge-from'
compdef _git gmfrom=git-merge

alias gmfromorigin='_git-merge-from-origin'
compdef _git gmfromorigin=git-merge

alias gmfromroot='_git-merge-from-root'
compdef _git gmfromroot=git-merge

alias gmfromupstream='_git-merge-from-upstream'
compdef _git gmfromupstream=git-merge

# alias gpatchit='_git-patchit'
# compdef _git gpatchit=git-am

alias grours="git checkout --ours"
compdef _git grours=git-checkout

alias grup="git remote update -p"
compdef _git grup=git-remote-update

alias grtheirs="git checkout --theirs"
compdef _git grtheirs=git-checkout

alias gs='git status'
compdef _git gs=git-status

alias gsdel='_git-stash-delete'
compdef _git gsdel=git-stash

alias gsl='git stash list'
compdef _git gsl=git-stash-list

alias gsp='git stash pop'
compdef _git gsp=git-stash-pop

alias gst='git stash'
compdef _git gst=git-stash

alias gtag='git tag'
compdef _git gtag=git-tag

alias gtaga='git tag -a'
compdef _git gtaga=git-tag

alias gunadd='git reset HEAD'
compdef _git gunadd=git-reset

alias gun='git reset && git checkout . && git clean -fdx'
compdef _git gun=git-reset

alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git commit -m "--wip--"'

# alias gfupdate='git-flow-update'
