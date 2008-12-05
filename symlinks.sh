#!/bin/bash

ddir=`dirname $0`
files=`find $ddir -maxdepth 1 ! -path $ddir ! -path $ddir/.gitignore ! -path $ddir/.git ! -path $0`

mkdir dotfiles-bkp
for f in $files; do
  base=`basename $f`
  if [ -e $base ]; then
    mv $base dotfiles-bkp
  fi
  ln -s $ddir/$base
done
