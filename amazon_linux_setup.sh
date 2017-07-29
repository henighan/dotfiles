#!/bin/bash

sudo yum install tmux
git clone https://github.com/henighan/dotfiles.git ~/
cp .vimrc ~/
cp -R .vim/ ~/.vim
cp .tmux.conf ~/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
