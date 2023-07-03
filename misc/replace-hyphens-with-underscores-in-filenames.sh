#!/bin/bash

input_file=$1
output_file="$(echo "$1" | sed "s/,//g" | tr "[:upper:]" "[:lower:]" | sed "s/\s-\s/_/g" | sed --regexp-extended "s/\s/-/g" | sed "s/--/_/g")"

mv "./$input_file" "./$output_file"

ls -la "./$output_file"
