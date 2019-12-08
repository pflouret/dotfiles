#!/bin/bash

mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ddir=`dirname $0`
files=`find $ddir -maxdepth 1 ! -path $ddir ! -path $ddir/old ! -path $ddir/.gitignore ! -path $ddir/.git ! -path '*.sh'` ! -path Brewfile

mkdir dotfiles-bkp
for f in $files; do
  base=`basename $f`
  if [ -e $base ]; then
    mv $base dotfiles-bkp
  fi
  ln -s $ddir/$base
done
