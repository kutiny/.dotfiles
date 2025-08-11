# !/bin/bash

platform=$(uname)
platform="Linux"
if [ $platform = "Darwin" ]; then
    printf ""
elif [ $platform = "Linux" ]; then
    printf ""
fi

printf " ${platform}"
