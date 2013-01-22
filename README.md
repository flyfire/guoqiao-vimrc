guoqiao-vimrc
=============

guoqiao's vimrc

feature
=======
this repo itself is so simple and lightweighted that it contains only a vimrc and only one plugin pathogen.
all other plugins are managed by pathogen, which is a greate vim plugin put all others plugins in bundle dir.
thus, you need not to dispatch plugin files to different dirs, which makes management and updating so annoying.
it's just simple, easy and cool.

what's more, i collect the most usefull plugins very carefully.

usage
=====
run

    helper.py -c

to clone all plugins from github (maybe walled now, damn it!). and

    helper.py -p

to pull (update) all.

so you need python and git installed on your system.

on linux, you just need to run

    ./install.sh

this will rm your old .vimrc and .vimfiles in you ~, and then create links for them to here.

on windows, it seems that links do not work.
so you may have to just copy all files here to your dir in which your vim files lie in.


usefull shortcuts
=================
tt toggle the file tree on the left
TT toggle the tag list on the right

tn tab new
tc tab close
tl tab next
th tab prev
tm tab mv
to tab only(close all others)

ctrl+h,j,k,l to move around between windows, no need to ctrl+w+h,j,k,l

F3 to open loop clipboard, which can paste from history and even other vim instances.
also, if you press p to paste, but you need previous item in clipboard, just press ctrl+p to mv next.

',' is my leader key.
,+h will rm highlight of search results
,+w to save
,+e to reload
,+x to save and exit

there's also many others, it's a long story to say all of them.
just use and enjoy it.

