#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "${PWD}/${BASH_SOURCE}")

# Absolute path this script is in. /home/user/bin
TOP_PATH=`dirname "$SCRIPT"`

echo rm old files...
rm ~/.vimrc
rm -rf ~/.vim

echo link new files...
ln -s $TOP_PATH/_vimrc ~/.vimrc
ln -s $TOP_PATH/vimfiles ~/.vim

echo done!
