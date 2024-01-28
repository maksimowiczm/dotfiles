#!/bin/zsh

BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
COLOR_OFF='\033[0m'

# script directory
DIR=$(dirname "$(readlink -f "$0")")

function info(){
    echo "${YELLOW}$1 ${COLOR_OFF}"
}

function error(){
    echo "${RED}$1 ${COLOR_OFF}"
}

# install paru AUR helper
function install_paru()
{
    info "Installing paru"
    
    if ! type rustup &> /dev/null; then
        info "Installing rustup"
        sudo pacman -S --needed --noconfirm rustup
    fi
    
    if rustup toolchain list | grep 'no installed toolchains'; then
        rustup toolchain install stable
    fi
    
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm --needed
    cd ..
    rm -rf paru
    
    info "Paru installed"
}

function setup_symlink()
{
    info "Linking ~/$1 -> $DIR/$1"
    rm -rf ~/$1
    ln -s $DIR/$1 ~/$1
}

function install_zsh_config(){
    info "Installing zsh"
    
    info "Installing Oh My Zsh"
    rm -rf ~/.oh-my-zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &> /dev/null
    
    info "Seting up .zshrc"
    rm -rf ~/.zshrc
    cp $DIR/.zshrc ~/.zshrc
    source ~/.zshrc
    
    info "Setting up OMZ plugins"
    
    # install plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    curl -L https://git.io/auto-ls > ${ZSH_CUSTOM}/plugins/zsh-auto-ls
    
    source ~/.zshrc
}

function link_kitty_config(){
    setup_symlink ".config/kitty"
}

function link_hyprland_config(){
    setup_symlink ".config/hypr"
    setup_symlink ".config/waybar"
    setup_symlink ".config/wofi"
}

function link_i3_config(){
    setup_symlink ".config/i3"
    setup_symlink ".config/i3status"
}

function install_arch_packages(){
    # install paru
    if ! type paru &> /dev/null; then
        install_paru
        
        if ! type paru &> /dev/null; then
            error "Failed to install paru"
            exit 1
        fi
    fi
    
    # install resources (fonts, zsh plugins dependencies)
    info "Installing packages"
    if ! paru -S --needed --skipreview --noconfirm $(cat $DIR/arch-packages.txt); then
        error "Failed to install packages"
        exit 1
    fi
}

################################################################################
#####################################START######################################
################################################################################

declare -A installers
installers[arch]='install_arch_packages'
installers[zsh]='install_zsh_config'

declare -A configs
configs[kitty]='link_kitty_config'
configs[hyprland]='link_hyprland_config'
configs[i3]='link_i3_config'

mkdir -p ~/.config

if [[ $# -eq 0 ]]; then
    error "Error: No arguments provided. Exiting."
    exit 1
fi

if [ "$1" = "all" ]; then
    for arg in "${installers[@]}"; do
        $arg
    done
    for arg in "${configs[@]}"; do
        $arg
    done
    
    exit 0
fi

if [ "$1" = "config" ]; then
    for arg in "${configs[@]}"; do
        $arg
    done
    
    exit 0
fi

for arg in "$@"; do
    $installers[$arg]
    $configs[$arg]
done

exit 0