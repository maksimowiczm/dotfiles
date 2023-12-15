export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  # system
  systemd
  colored-man-pages

  # ops
  git
  gitignore
  git-auto-fetch
  docker
  npm

  # qol
  vi-mode
  autojump
)

source $ZSH/oh-my-zsh.sh

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", from:github

zplug "desyncr/auto-ls", from:github

zplug "zsh-users/zsh-autosuggestions", as:plugin

# zplug load --verbose
zplug load
