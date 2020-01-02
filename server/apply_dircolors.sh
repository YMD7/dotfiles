#!/bin/sh

echo "Start 'git clone' Nord dircolors"
echo "***[https://github.com/arcticicestudio/nord-dircolors]"

mkdir -p ~/tmp
git clone git@github.com:arcticicestudio/nord-dircolors.git ~/tmp/.

echo "Copy dircolors file to '~/.dircolors'..."
cp tmp/src/dir_colors ~/.dircolors

echo "Apply dircolors"
eval `dircolors .dircolors`

echo "Finish"


