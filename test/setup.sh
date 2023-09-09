# ユーザーを作成
echo "Creating a test user..."
useradd -m -s /bin/bash test
echo "test:test" | chpasswd

# rootとしてGitをインストール
echo "Installing Git as root..."
apt update
apt install -y git

# testユーザーに切り替え
su - test
cd ~
echo "Environment setup completed."
