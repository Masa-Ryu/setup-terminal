#!/bin/bash

# read greeting.sh
./scripts/greeting.sh

# install zsh
if [ ! -f /usr/bin/zsh ]; then
    echo "Do you want to install zsh? (y/n)"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        echo "Installing zsh..."
        sudo apt install -y zsh
        echo "Done!"
        echo ""
    fi
fi

# install curl
if [ ! -f /usr/bin/curl ]; then
    echo "Installing curl..."
    sudo apt install -y curl
    echo "Done!"
    echo ""
fi

# install zinit
if [ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]; then
    echo "Installing zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    zinit self-update
    echo "zinit ice depth=1" >>~/.zshrc
    echo "## plugins" >>~/.zshrc
    echo "zinit light zsh-users/zsh-autosuggestions" >>~/.zshrc
    echo "zinit light zdharma-continuum/fast-syntax-highlighting" >>~/.zshrc
    echo "zinit light zsh-users/zsh-completions" >>~/.zshrc
    echo "light agkozak/zsh-z" >>~/.zshrc
    echo "Done!"
    echo ""
fi

# install Meslo font
echo "Installing Meslo font..."
mkdir -p ~/.local/share/fonts

./install.sh Meslo
fc-cache -fv
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/blob/7deaff60d02ad26c38f4f8cc714300c08f598b1e/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf
cd ~
echo "Done!"
echo ""

#install p10k theme
echo "Installing p10k theme..."
echo "zinit light romkatv/powerlevel10k" >>~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>~/.zshrc
echo "Done!"
echo ""

# set up zshrc
echo "Setting up .zshrc..."
mkdir -p ~/.config/zsh/functions
cd ~/setup-zsh
cp config/style.zsh ~/.config/zsh/
cp config/aliases.zsh ~/.config/zsh/
cp config/ubuntu.zsh ~/.config/zsh/
cp config/history.zsh ~/.config/zsh/
cp config/git.zsh ~/.config/zsh/
cp config/functions_tmux.zsh ~/.config/zsh/functions/
cp config/python.zsh ~/.config/zsh/
cp config/rust.zsh ~/.config/zsh/

echo "source ~/.config/zsh/style.zsh" >>~/.zshrc
echo "source ~/.config/zsh/aliases.zsh" >>~/.zshrc
echo "source ~/.config/zsh/ubuntu.zsh" >>~/.zshrc
echo "source ~/.config/zsh/history.zsh" >>~/.zshrc
echo "source ~/.config/zsh/git.zsh" >>~/.zshrc
echo "source ~/.config/zsh/functions_tmux.zsh" >>~/.zshrc
echo "source ~/.config/zsh/python.zsh" >>~/.zshrc
echo "source ~/.config/zsh/rust.zsh" >>~/.zshrc

rm -rf setup-zsh
source ~/.zshrc
zsh
echo "Done!"
echo ""
echo "If you want to set default shell, run 'chsh -s /usr/bin/zsh'"
