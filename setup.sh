#!/bin/bash

DOT_FILES=( .zshrc .emacs.d .gitconfig .gitignore .vimrc .tmux.conf .bashrc )

for file in ${DOT_FILES[@]}
do
      mv $HOME/$file $HOME/$file.orig
      ln -s $HOME/dotfiles/$file $HOME/$file
done
