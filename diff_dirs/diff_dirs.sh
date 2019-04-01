#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage $0 'dir1/' 'dir2/'"
    exit 1
fi

if [ -d "$1" ]; then
    dir1=$1
else
    echo "$1 does not exist!"
    exit 1
fi 

if [ -d "$2" ]; then
    dir2=$2
else
    echo "$2 does not exist!"
    exit 1
fi 

dir1_list=/tmp/dir1_list.txt
dir2_list=/tmp/dir2_list.txt
diff=files_diff
exclude_pat=/home/ivan/Documents/diff_dirs/exclude_diff

diff -uwBNrq -X $exclude_pat $dir1 $dir2 | awk '{print $2}' > $dir1_list
diff -uwBNrq -X $exclude_pat $dir1 $dir2 | awk '{print $4}' > $dir2_list

echo "Files that differ:"
echo "=================="
if [ "$(cat $dir1_list)" == "" ]; then
    echo "No differences found!"
    exit 0;
else
    vim $dir1_list
fi

while true
do
    echo "======================="
    echo "Press 1 to show vimdiff"
    echo "Press 2 to patch $dir1"
    echo "Press 3 to patch $dir2"
    echo "Press q to exit"
    read ans

    if [ "$ans" == "1" ]; then
        while read file1 <&3 && read file2 <&4; do
            echo "Next file is $(basename "$file1")"
            echo "Press: 'Enter' to see diff"
            echo "       'q'     to exit"
            echo "       any other input to skip"
            read input
     
            if [ "" == "$input" ]; then
                vimdiff $file1 $file2
            elif [ "q" == "$input" ]; then
                break
            fi
        done 3<$dir1_list 4<$dir2_list
    elif [ "$ans" == "2" ]; then
        > $diff
        while read file1 <&3 && read file2 <&4; do
            diff -uwB $file1 $file2 >> $diff
        done 3<$dir1_list 4<$dir2_list

        dir2_strip=$(echo $dir2 | tr -cd / | wc -c)
        patch -d $dir1 -p$dir2_strip < $diff
    elif [ "$ans" == "3" ]; then
        > $diff
        while read file1 <&3 && read file2 <&4; do
            diff -uwB $file2 $file1 >> $diff
        done 3<$dir1_list 4<$dir2_list

        dir1_strip=$(echo $dir1 | tr -cd / | wc -c)
        patch -d $dir2 -p$dir1_strip < $diff
    elif [ "$ans" == "q" ]; then
        exit 0
    fi
done

