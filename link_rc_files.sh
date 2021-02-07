#!/bin/bash

[[ ! -f ~/.zshrc ]] || mv ~/.zshrc ~/.old_zshrc
ln -s  ~/dotfiles/zshrc ~/.zshrc

[[ ! -f ~/.vimrc ]] || mv ~/.vimrc ~/.old_vimrc
ln -s  ~/dotfiles/vimrc ~/.vimrc

[[ ! -f ~/.gitignore ]] || mv ~/.gitignore ~/.old_gitignore
ln -s  ~/dotfiles/gitignore ~/.gitignore

[[ ! -f ~/.gitconfig ]] || mv ~/.gitconfig ~/.old_gitconfig
ln -s  ~/dotfiles/gitconfig ~/.gitconfig

[[ ! -f ~/.tmux.conf ]] || mv ~/.tmux.conf ~/.old_tmux.conf
ln -s  ~/dotfiles/tmux.conf ~/.tmux.conf
