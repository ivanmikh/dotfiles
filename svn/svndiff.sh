#!/bin/bash

CWD=$(pwd)
LIST="${CWD}/svndiff.txt"

svn diff --summarize | awk '{print $2}' > $LIST
if [ -s $LIST ]; then
    vim $LIST
else
    echo "No differences found!"
fi

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

if [ "update" == "$1" ]; then
    for file in $(cat $LIST); do
        svn update $file
    done
elif [ "commit" == "$1" ]; then
    svn commit --targets $LIST
fi

