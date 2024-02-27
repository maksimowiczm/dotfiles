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

  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source ${ZSH_CUSTOM}/plugins/zsh-auto-ls
