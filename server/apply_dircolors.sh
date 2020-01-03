#!/bin/sh

echo "Start 'git clone' Solarized Color Theme for GNU"
echo "***[https://github.com/seebi/dircolors-solarized]"

mkdir -p ~/tmp
git clone git@github.com:seebi/dircolors-solarized.git ~/tmp/dircolors-solarized

echo "Copy dircolors file to '~/.dircolors'"
cp ~/tmp/dircolors-solarized/dircolors.256dark ~/.dircolors

echo "Apply dircolors"
eval `dircolors .dircolors`

echo "Finish"

