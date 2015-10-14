#!/bin/bash

ok="On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean"

dirs=" ~/.sh ~/dotfiles"

function Main {
    for file in $dirs; do
	verify $file
    done

    clear

    for file in $dirs; do
	echo Ok: $file
    done
}

function verify {
    batata=false
    cd $1
    while [ $batata == false ]; do
	if [ "$(git status)" == "$ok" ]; then
	    echo Ok: $(pwd)
	    batata=true
	else
	    echo not ok
	    git add *
	    git commit -m "$(date)"
	    git push
	fi
    done
    clear
    echo Ok: $(pwd)
}

Main
