#!/bin/bash

# read greeting.sh
./greeting.sh

# install zsh
if [[ ! -f /usr/bin/zsh ]]; then
    echo "Do you want to install zsh? (y/n)"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Installing zsh..."
        sudo apt install zsh
        echo "Done!"
    fi
fi

# set zsh as default shell
echo "Do you want to set zsh as default shell? (y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
    echo "Done!"
fi

# install curl
if [[ ! -f /usr/bin/curl ]]; then
    echo "Installing curl..."
    sudo apt install curl
    echo "Done!"
fi

# install zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    echo "Installing zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    sorce ~/.bashrc
    zinit self-update
    echo "zinit ice depth=1" >> ~/.zshrc
    echo "## plugins" >> ~/.zshrc
    echo "zinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
    echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> ~/.zshrc
    echo "zinit light zsh-users/zsh-completions" >> ~/.zshrc
    echo "light agkozak/zsh-z" >> ~/.zshrc
    echo "Done!"
fi

# install Meslo font
git clone https://github.com/ryanoasis/nerd-fonts.git
echo "Installing Meslo font..."
cd nerd-fonts
./install.sh Meslo
fc-cache -fv
cd ~
rm -rf nerd-fonts

#install p10k theme
echo "Installing p10k theme..."
echo "zinit light romkatv/powerlevel10k" >> ~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
echo "Done!"

# set up zshrc
echo "Setting up .zshrc..."
mkdir -p ~/.config/zsh/functions
cp config/style.zsh ~/.config/zsh/
cp config/aliases.zsh ~/.config/zsh/
cp config/ubuntu.zsh ~/.config/zsh/
cp congig/histoty.zsh ~/.config/zsh/
cp config/git.zsh ~/.config/zsh/
cp config/funtions_tmux.zsh ~/.config/zsh/functions/
cp config/python.zsh ~/.config/zsh/
cp config/rust.zsh ~/.config/zsh/

echo "source ~/.config/zsh/style.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/aliases.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/ubuntu.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/history.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/git.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/functions_tmux.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/python.zsh" >> ~/.zshrc
echo "source ~/.config/zsh/rust.zsh" >> ~/.zshrc
echo "Done!"