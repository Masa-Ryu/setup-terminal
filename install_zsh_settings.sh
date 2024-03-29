#!/bin/bash

CURRENT_DIR=$PWD

# read greeting.sh
./scripts/greeting.sh

print_success() {
    echo "\033[32m$1\033[0m"
    echo ""
}
print_error() {
    echo "\033[31m$1\033[0m"
    echo ""
}

# install zsh
cd $HOME
if [ ! -f /usr/bin/zsh ]; then
    echo "Do you want to install zsh? (y/n)"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        echo "Installing zsh..."
        sudo apt install -y zsh
        print_success "SUCCESS: Done!"
    fi
fi

# install curl
cd $HOME
if [ ! -f /usr/bin/curl ]; then
    echo "Installing curl..."
    sudo apt install -y curl
    print_success "SUCCESS: Done!"
fi

# install zinit
cd $HOME
if [ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]; then
    echo "Installing zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    echo "zinit ice depth=1" >>$HOME/.zshrc
    echo "## plugins" >>$HOME/.zshrc
    echo "zinit light zsh-users/zsh-autosuggestions" >>$HOME/.zshrc
    echo "zinit light zdharma-continuum/fast-syntax-highlighting" >>$HOME/.zshrc
    echo "zinit light zsh-users/zsh-completions" >>$HOME/.zshrc
    echo "zinit light agkozak/zsh-z" >>$HOME/.zshrc
    echo "typeset -g POWERLEVEL9K_INSTANT_PROMPT=off" >>$HOME/.zshrc
    print_success "SUCCESS: Done!"
fi

# install Meslo font
cd $HOME
echo "Installing Meslo font..."
mkdir -p $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/blob/7deaff60d02ad26c38f4f8cc714300c08f598b1e/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf
print_success "SUCCESS: Done!"

#install p10k theme
cd $HOME
echo "Installing p10k theme..."
echo "zinit light romkatv/powerlevel10k" >>~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>~/.zshrc
print_success "SUCCESS: Done!"

# set up zshrc
echo "Setting up .zshrc..."
mkdir -p ~/.config/zsh/functions
cp $CURRENT_DIR/config/style.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/aliases.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/ubuntu.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/history.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/git.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/functions_tmux.zsh $HOME/.config/zsh/functions/
cp $CURRENT_DIR/config/python.zsh $HOME/.config/zsh/
cp $CURRENT_DIR/config/rust.zsh $HOME/.config/zsh/

echo "" >>$HOME/.zshrc
echo "# zsh settings" >>$HOME/.zshrc
echo "source ~/.config/zsh/style.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/aliases.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/ubuntu.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/history.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/git.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/functions/functions_tmux.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/python.zsh" >>$HOME/.zshrc
echo "source ~/.config/zsh/rust.zsh" >>$HOME/.zshrc

cd $HOME
rm -rf $CURRENT_DIR
print_success "SUCCESS: Done!"
print_success "If you want to set as default shell, type 'chsh -s /usr/bin/zsh'"
zsh
