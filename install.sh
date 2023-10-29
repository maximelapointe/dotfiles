#!/bin/bash

zsh-plugins() {
    echo "==========================================================="
    echo "             Cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"                    
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "==========================================================="
    echo "             Cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

zsh-theme() {
    echo "==========================================================="
    echo "             Cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # ZSH_THEME="powerlevel10k/powerlevel10k" should be set in .zshrc!

    echo "==========================================================="
    echo "             Setting font                                  "
    echo "-----------------------------------------------------------"
    #TODO check the ttf files, need to install all 4
    #TODO need to configure terminal to use the font
    #TODO configure jetbrains to also use console font instead of the default
}

import-dotfiles() {
    echo "==========================================================="
    echo "             Import .zshrc                                 "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc

    echo "==========================================================="
    echo "             Import .p10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh
}

edit-zshrc() {
    # Make highlighting readable - needs to be after zshrc line
    echo "" >> ~/.zshrc
    echo "# remove ls and directory completion highlight color" >> ~/.zshrc
    echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
    echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
    echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc
}

zsh-install() {
    echo "==========================================================="
    echo "             Install zsh                                   "
    echo "-----------------------------------------------------------"
    sudo dnf install zsh -y
    # sudo yum -y install zsh
}

oh-my-zsh-install() {
    echo "==========================================================="
    echo "             Install oh-my-zsh                             "
    echo "-----------------------------------------------------------"
    # sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #TODO ^^ Needs a fix to install without dynamic prompts (asking to turn zsh as default shell). Will make zsh default shell in line below
    # chsh -s /bin/zsh. # Only works after relogging!
}

git-config() {
    #TODO
    #git config --global user.email "you@example.com"
    #git config --global user.name "Your Name"
}

timezone() {
    echo "==========================================================="
    echo "             Change timezone                               "
    echo "-----------------------------------------------------------"
    sudo ln -fs /usr/share/zoneinfo/America/Montreal /etc/localtime
    sudo dpkg-reconfigure --frontend noninteractive tzdata
}

zsh-install
zsh-plugins
zsh-themes
oh-my-zsh-install
import-dotfiles
#edit-zshrc
git-config
timezone
