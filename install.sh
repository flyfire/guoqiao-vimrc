#!/bin/bash
echo rm old files...
rm ~/.vimrc
rm -rf ~/.vim
echo link new files...
ln -s ~/git/guoqiao-vimrc/_vimrc ~/.vimrc
ln -s ~/git/guoqiao-vimrc/vimfiles ~/.vim
echo done!
