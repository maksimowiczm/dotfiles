#!/bin/bash

quiet=false
if [ "$1" = "all" ]; then
    quiet=true
fi

function ask() {
    if $quiet;then
        return 0
    fi
    
    read -p "$1 [Y/n]: " resp
    if [ -z "$resp" ]; then
        response_lc="y"
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]')
    fi
    
    [ "$response_lc" = "y" ]
}


function install_paru()
{
    echo "Installing paru"
    
    if type paru &> /dev/null; then
        echo "Paru already installed"
        return
    fi
    
    if rustup toolchain list | grep 'no installed toolchains'; then
        if ask "Install rustup toolchain stable?"; then
            rustup toolchain install stable
        fi
    fi
    
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    
    echo "Paru installed"
}


DIR=$(dirname "$(readlink -f "$0")")
function install_symlink()
{
    echo "Seting up $1"
    
    rm -rf ~/$1
    ln -s $DIR/$1 ~/$1
}


# Set up AUR helper
if ! $quiet; then
    echo "Which AUR helper should I use? [default = paru]"
    read aur
fi

if [ -z "$aur" ]; then
    aur=paru
fi

if ! type $aur &> /dev/null; then
    if ask "$aur not found. Install paru?"; then
        install_paru
        aur=paru
        
        if ! type $aur &> /dev/null; then
            echo "Failed to run $aur. Exiting..."
            exit 1
        fi
    else
        echo "AUR helper is required"
        exit 1
    fi
fi


# Install packages.txt
if ask "Install packages?"; then
    if ! $aur -S --needed --skipreview $(cat $DIR/packages.txt); then
        exit 1
    fi
fi


# Hyprland
if ask "Install hyprland? This will override your configuration."; then
    install_symlink ".config/hypr"
    
    if ask "Install waybar? This will override your configuration."; then
        install_symlink ".config/waybar"
    fi
fi


# Kitty
if ask "Install kitty? This will override your configuration."; then
    install_symlink ".config/kitty"
fi

# zsh
if ask "Setup zsh? This will override your configuration."; then
    # omz
    rm -rf ~/.oh-my-zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &> /dev/null
    echo "Installing Oh My Zsh"
    
    # zplug
    rm -rf ~/.zplug
    git clone https://github.com/zplug/zplug ~/.zplug &> /dev/null
    echo "Installing zplug"
    
    rm -rf ~/.zshrc
    cp $DIR/.zshrc ~/.zshrc
    echo "Seting up .zshrc"
    
    if ! [ "$SHELL" = "/usr/bin/zsh" ];then
        chsh -s $(which zsh)
    fi
fi