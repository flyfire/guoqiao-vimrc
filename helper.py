#!ENV/bin/python
# -*- coding: utf-8 -*-

import os
import subprocess
from optparse import OptionParser

HERE = os.path.abspath(os.path.dirname(__file__))
BUNDLE = os.path.join(HERE,'vimfiles','bundle')

GIT_REPOS = (
        'https://github.com/tomasr/molokai.git',
        'https://github.com/mattn/zencoding-vim',
        'https://github.com/tpope/vim-repeat.git',
        'https://github.com/tpope/vim-surround.git',
        'https://github.com/scrooloose/nerdtree.git',
        'https://github.com/scrooloose/nerdcommenter.git',
        'https://github.com/vim-scripts/YankRing.vim.git',
        'https://github.com/mitechie/pyflakes-pathogen.git',
        'https://github.com/vim-scripts/python-imports.vim.git',
        )

def clone():
    for r in GIT_REPOS:
        print 'clone %s ...' % r
        cmd = 'git clone %s' % (r,)
        subprocess.call(cmd.split(),cwd=BUNDLE)

def pull():
    for name in os.listdir(BUNDLE):
        path = os.path.join(BUNDLE,name)
        if os.path.isdir(path):
            print 'pull %s ...' % path
            cmd = 'git pull'
            subprocess.call(cmd.split(),cwd=path)

def main():
    if not os.path.exists(BUNDLE):
        os.mkdir(BUNDLE)
    parser = OptionParser()
    parser.add_option("-c", "--clone",
                      action="store_true", dest="clone", default=False,
                      help="clone all repos")
    parser.add_option("-p", "--pull",
                      action="store_true", dest="pull", default=False,
                      help="pull all repos")

    (options, args) = parser.parse_args()

    if options.clone:
        clone()
    elif options.pull:
        pull()
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
