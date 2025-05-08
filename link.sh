#!/usr/bin/env bash

# Clone dotfiles into ~/dotfiles, then run this.

cd $HOME
for i in $(ls -a dotfiles/ | grep "^\.[^\.]" | grep -v '^.git$')
do
  [ -f $i -o -d $i  ] && echo "$i exists: skipping." || (ln -s dotfiles/$i && echo "Linked $i.")
done

mkdir -p .config
cd .config
for dir in ghostty
do
  [ -d "$dir" ] && echo ".config/$dir exists: skipping." || (ln -s ../dotfiles/$dir && echo "Linked .config/$dir")
done
