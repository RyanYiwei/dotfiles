sudo apt update
sudo apt install -y build-essential

# zsh
[-f $HOME/.zshrc] && cp ~/.zshrc ~/.zsh/.zshrc.bak_$(date +%Y%m%d)
cp ./.zshrc $HOME/.zshrc
cp -r ./.zsh $HOME

# Curl
command -v curl &> /dev/null || sudo apt-get install curl

# Cargo
[ -d $HOME/.cargo ] || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# modern unix tools
command -v exa &> /dev/null || cargo install exa
if command -v fzf &> /dev/null; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
command -v zoxide &> /dev/null || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
command -v batcat &> /dev/null || sudo apt -y install bat

# chisel
curl https://i.jpillora.com/chisel! | bash

# tmux
command -v tmux &> /dev/null || sudo apt -y install tmux
cp ./.tmux.conf $HOME/.tmux.conf