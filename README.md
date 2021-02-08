# Setup

I want to:
1. Become productive with a new laptop as quickly and painlessly as possible
1. Make it easy to use subsets of my preferred configuration on another machine (eg, configure vim on a remote machine) without having to memorize all the details.

To accommodate the above, I store my config files in this repo, and (try to) document here how to use them on a brand new laptop (macboook). Config files include:
1. [Brewfile](.Brewfile) contains most of the mac applications that I use and allows me to install them with the [homebrew](https://brew.sh/) package manager.
1. [.zshrc](zshrc) for zshell config
1. [.vimrc](vimrc) for vim config
1. [.tmux.conf](tmux.conf) for tmux config
1. [.gitignore](gitignore)+[.gitconfig](gitconfig) for git config


If others find pieces of this useful, that would be a nice side-effect :smile:

Below are my best attempt at instructions for setting up a brand new laptop


# First, make sure OS is up to date
Often it ships with an outdated OS, and I think its worth doing the software upgrade before the rest of this.

# Modifier key / Hotkeys
I use ctrl a lot and caps-lock never, so...
Settings -> keyboard -> modifier keys -> change caps lock to ctrl

I find these navigation keys for google chrome more pleasant than the defaults. Note `h` and `l` do in vim what the left and right arrow keys typically do.
In keyboard shortcuts, Select “App Shortcuts” from the left menu and start adding the following for google chrome:
1. New Tab: ^N
1. Close Tab: ^K
1. Select Next Tab: ^L
1. Select Previous Tab: ^H

# Open mac Terminal
We're gonna have to run a bunch of terminal commands. Eventually we'll switch to the preferred terminal program, `iterm`

# Install xcode
```bash
xcode-select --install
```

# Install homebrew
At the time of writing, the command to install is
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install instructions at
https://brew.sh/

# Clone this repo
```bash
cd && git clone https://github.com/henighan/dotfiles.git
```
Note we used https. We will switch to ssh later.


# Install brewfile
```bash
sudo brew bundle install --file=~/dotfiles/Brewfile
```
This’ll install all the things listed in the above brewfile. I find this magical.
Some package installations may fail, in which case it’ll say so and try to tell you what went wrong. Google and try to fix.

There are a couple packages that requires some extra setup after brew-installation:
## fzf
To install useful key bindings and fuzzy completion:
(brew --prefix)/opt/fzf/install

## miniconda
conda init "$(basename "${SHELL}")"
This will add a bunch of stuff to the bottom of ~/.zshrc. Cut out and move that stuff into a new `~/.conda.zsh` file.


I also had to run this to get zplug to work correctly:
```bash
sudo chown -R $(whoami) /usr/local/*
```

# Link config files
`cd ~/dotfiles && ./link_rc_files.sh`


# Quit terminal and open iterm
This will be the first time we source our fancy new zshrc. It will bring up some interactive prompts to help us get started:
1. Zplug will ask if you want to install some packages, press `y`
1. Powerlevel10k will take you through an incredible interactive journey allowing you to customize your terminal prompt to your liking. Just follow the instructions

# install tmux plugin manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Then press `^a + I` to install plugins
I had to make this change to `~/.tmux/plugins/tmux-spotify/scripts/artist.sh` to get the tmux-spotify artist to work correctly
https://github.com/robhurring/tmux-spotify/pull/6/files

# install vim plugin manager
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Open vim and run
```
:PlugInstall
```

# Create a new github ssh key
follow these instructions
https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# Use ssh for dotfiles remote (henighan only)
```bash
cd ~/dotfiles
git remote set-url origin git@github.com:henighan/dotfiles.git
```
Why do I need to do this? IIUC, https doesnt work when you use 2-factor authentication on github. So if I want to be able to push to dotfiles, I need to swith it to ssh.
