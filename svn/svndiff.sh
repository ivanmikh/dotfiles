#!/bin/bash

CWD=$(pwd)
DIR_NAME=$(basename $CWD)
LIST="/tmp/svndiff_${DIR_NAME}.txt"

svn diff --summarize | awk '{print $2}' > $LIST
if [ -s $LIST ]; then
    nvim $LIST
else
    echo "No differences found!"
fi

if [ "update" == "$1" ]; then
    for file in $(cat $LIST); do
        svn update $file
    done
    echo "Press enter"
    read
elif [ "commit" == "$1" ]; then
    svn commit --targets $LIST
    echo "Press enter"
    read
elif [ "revert" == "$1" ]; then
    svn revert --targets $LIST
    echo "Press enter"
    read
else
    for file in $(cat $LIST); do
        echo "Next file is $file"
        echo "Press: 'Enter' to see diff"
        echo "       'q'     to exit"
        echo "       any other input to skip"
        read input
    
        if [ "" == "$input" ]; then
            svn diff $file
        elif [ "q" == "$input" ]; then
            break
        fi
    done
fi

