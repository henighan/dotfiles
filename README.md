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

### The rest of this readme contains my best attempt at instructions for setting up a brand new (macbook) laptop

# First, make sure OS is up to date

Often it ships with an outdated OS, and I think its worth doing the software upgrade before the rest of this.

# Modifier key / Hotkeys

I use ctrl a lot and caps-lock never, so...
Settings -> keyboard -> modifier keys -> change caps lock to ctrl

In the `shortcuts` tab, select `keyboard` in the left menu and change "Move focus to next window" from cmd+` to cmd+'. I find this less annoying

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

Install instructions at
https://brew.sh/

# Make a `~/code` directory

Code goes there

```bash
mkdir ~/code
```

# Clone this repo into a `code`

```bash
cd ~/code && git clone https://github.com/henighan/dotfiles.git
```

Note we used https. We will switch to ssh later.

# Install brewfile

```bash
brew bundle install --file=~/dotfiles/Brewfile
```

This’ll install all the things listed in the above brewfile. I find this magical.
Some package installations may fail, in which case it’ll say so and try to tell you what went wrong. Google and try to fix.

There are a couple packages that requires some extra setup after brew-installation:

## Powerlevel10k

```bash
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
```

Or whatever it says [here](https://github.com/romkatv/powerlevel10k#homebrew)

## fzf

To install useful key bindings and fuzzy completion:
(brew --prefix)/opt/fzf/install

## zsh-syntax-highlighting

```bash
echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

or something similar, see what brew output said

## miniconda

conda init "$(basename "${SHELL}")"
This will add a bunch of stuff to the bottom of ~/.zshrc.

I also had to run this to get zplug to work correctly:

```bash
sudo chown -R $(whoami) /usr/local/*
```

# Link config files

`cd ~/code/dotfiles && ./link_rc_files.sh`

# Quit terminal and open iterm

This will be the first time we source our fancy new zshrc. It will bring up some interactive prompts to help us get started:

1. Powerlevel10k will take you through an incredible interactive journey allowing you to customize your terminal prompt to your liking. Just follow the instructions

# Create a new github ssh key

follow these instructions
https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
