#!/bin/bash

brew update
brew upgrade

brew install coreutils findutils
brew install wget --enable-iri
brew install ag calc cowsay ctags dos2unix fortune git htop tree zsh-completions
brew install midnight-commander mercurial node pidof readline renameutils
brew install ssh-copy-id tig unrar watch wget python ffmpeg imagemagick
brew install caskroom/cask/flash-npapi caskroom/cask/flash-ppapi

brew tap homebrew/dupes
brew tap homebrew/versions
brew install homebrew/dupes/grep homebrew/dupes/vim

brew cleanup
