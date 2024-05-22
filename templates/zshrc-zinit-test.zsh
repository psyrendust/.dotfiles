# Initialize zinit
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# oh-my-zsh startup files
zinit ice depth=1; zinit light robbyrussell/oh-my-zsh

# oh-my-zsh plugins
zinit ice wait"0" blockf; zinit load ohmyzsh/ohmyzsh plugins/(colorize command-not-found copyfile copypath cp encode64 extract fd git macos man systemadmin urltools yarn)

# misc plugins
zinit ice wait"0" blockf; zinit load $ZDOT_BREW_ROOT/opt/fzf shell/*.zsh
zinit ice wait"0" blockf; zinit load bigH/git-fuzzy bin/git-fuzzy
zinit ice wait"0" blockf; zinit load lukechilds/zsh-nvm
zinit ice wait"0" blockf; zinit load agkozak/zsh-z

# dotfiles plugins
zinit ice wait"0" blockf; zinit load $ZDOT_PLUGINS/(aliases colored-man-pages fzf git git-fuzzy)

# zsh plugins
zinit ice wait"0" blockf; zinit load zsh-users/zsh-completions
zinit ice wait"0" blockf; zinit load zsh-users/zsh-syntax-highlighting
zinit ice wait"0" blockf; zinit load zsh-users/zsh-history-substring-search

# My prompt
export PURE_GIT_PULL=0
export PURE_GIT_UNTRACKED_DIRTY=0
zinit ice wait"0" blockf; zinit load mafredri/zsh-async
zinit ice wait"0" blockf; zinit load sindresorhus/pure
