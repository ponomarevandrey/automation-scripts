#!/bin/bash

# DESCRIPTION
#   Convert Cyrillic text files using Windows-1251 encoding to Linux UTF-8 
#
# SYNTAX 
#   ./script Readme1.txt > Readme2.txt

iconv -f windows-1251 -t UTF-8 $1 > $2 
