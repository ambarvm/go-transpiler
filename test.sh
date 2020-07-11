#!/bin/bash

testFiles=(`ls ./tests/*.go`)

green='\033[0;32m'
red='\033[0;31m'
nc='\033[0m'

for file in ${testFiles[@]}; do
    ./parse "$file"
    if [  $? -eq 0 ]; then
        echo -e "${green}✔${nc} $file"
    else
        echo -e "${red}✘${nc} $file"
    fi
done
