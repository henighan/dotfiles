#!/bin/bash

git clone https://github.com/henighan/dotfiles.git ~/
cp .vimrc ~/
cp -R .vim/ ~/.vim
cp .tmux.conf ~/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo apt-get install xclip
sudo apt-get install zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
