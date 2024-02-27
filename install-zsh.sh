#!/bin/zsh

# script directory
DIR=$(dirname "$(readlink -f "$0")")

function info(){
    echo "${YELLOW}$1 ${COLOR_OFF}"
}

info "Installing zsh"

info "Installing Oh My Zsh"
rm -rf ~/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &> /dev/null
source ~/.zshrc

info "Setting up OMZ plugins"

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
curl -L https://git.io/auto-ls > ${ZSH_CUSTOM}/plugins/zsh-auto-ls