#!/bin/bash

usage="Usage: $0 input_file.pdf output_file.pdf"

if [ $# -ne 2 ]; then
    echo "$usage"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "$1 does not exist!"
    echo "$usage"
    exit 1
fi

gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -r96 -sOutputFile="$2" "$1"
exit $?
