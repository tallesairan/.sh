#!/bin/bash

ok="On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean"

function Main {
    dir=~/.sh
    echo $(pwd)
    git=$(git status)
    verify $dir

    
}

function verify {
    batata=false
    cd $1
    while [ $batata == false ]; do
	if [ "$git" == "$ok" ]; then
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
