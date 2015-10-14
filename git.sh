#!/bin/bash

cd ~/.sh
echo $(pwd)
git=$(git status)
ok="On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean"

if [ "$git" == "$ok" ]; then
    echo ok
else
    echo not ok
    # git add *
    # git commit -m \" "$(date)" \"
    # git push
fi

