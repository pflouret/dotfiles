#!/bin/bash

brew update
brew upgrade

brew install coreutils findutils
brew install wget --enable-iri
brew install ack calc cowsay ctags dos2unix fortune git htop tree zsh-completions
brew install midnight-commander mercurial node pidof readline renameutils
brew install ssh-copy-id tig unrar watch wget python ffmpeg imagemagick

brew tap homebrew/dupes
brew tap homebrew/versions
brew install homebrew/dupes/grep homebrew/dupes/vim

brew cleanup
