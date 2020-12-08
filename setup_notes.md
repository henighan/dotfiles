# Setup

cd
xcode-select --install
# install homebrew
brew bundle install --file=~/dotfiles/Brewfile
git clone git@github.com:henighan/dotfiles.git
link tmux.conf, vimrc, zshrc
# install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
bash Miniconda3-latest-MacOSX-x86_64.sh
# install black (for auto-linting in vim)
pip install black
# install fzf
yes | $(brew --prefix)/opt/fzf/install --no-update-rc
# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
