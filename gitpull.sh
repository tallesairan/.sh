#!/bin/bash

dirs=" ~/.sh ~/dotfiles"

for file in $dirs; do
    cd $file
    git pull
done
