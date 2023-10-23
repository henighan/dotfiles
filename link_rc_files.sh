#!/bin/bash

echo  "source ~/code/dotfiles/zshrc" >> ~/.zshrc

[[ ! -f ~/.vimrc ]] || mv ~/.vimrc ~/.old_vimrc
ln -s  ~/code/dotfiles/noplugins.vimrc ~/.vimrc

[[ ! -f ~/.gitignore ]] || mv ~/.gitignore ~/.old_gitignore
ln -s  ~/code/dotfiles/gitignore ~/.gitignore

[[ ! -f ~/.gitconfig ]] || mv ~/.gitconfig ~/.old_gitconfig
ln -s  ~/code/dotfiles/gitconfig ~/.gitconfig

[[ ! -f ~/.tmux.conf ]] || mv ~/.tmux.conf ~/.old_tmux.conf
ln -s  ~/code/dotfiles/tmux.conf ~/.tmux.conf

[[ ! -f ~/Library/Application\ Support/Code/User/settings.json ]] || mv ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/old_settings.json
ln -s  ~/code/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

[[ ! -f ~/Library/Application\ Support/Code/User/keybindings.json ]] || mv ~/Library/Application\ Support/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/old_keybindings.json
ln -s  ~/code/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json