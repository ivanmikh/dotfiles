#!/bin/sh

BASE=${1}
LOCAL=${2}
REMOTE=${3}
MERGED=${4}
WCPATH=${5}

# copied from from git's vimdiff script
# @see https://github.com/git/git/blob/master/mergetools/vimdiff
vimdiff -f -d -c 'wincmd J' "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
