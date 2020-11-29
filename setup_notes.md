# Setup

cd
git clone git@github.com:henighan/dotfiles.git
link tmux.conf, vimrc, zshrc
xcode-select --install
# install homebrew
brew bundle install --file=~/dotfiles/Brewfile
# install fzf
yes | $(brew --prefix)/opt/fzf/install --no-update-rc
