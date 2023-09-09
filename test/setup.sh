# ユーザーを作成
echo "Creating a test user..."
useradd -m -s /bin/bash test
echo "test:test" | chpasswd

apt update
apt upgrade -y

echo "Installing sudo..."
apt install -y sudo
echo "test ALL=(ALL) ALL" >>/etc/sudoers

# rootとしてGitをインストール
echo "Installing Git as root..."
apt install -y git

# testユーザーに切り替え
echo ""
echo "Switching to test user..."
su - test -c "cd ~; git clone https://github.com/Masa-Ryu/setup-zsh.git; cd setup-zsh;"
