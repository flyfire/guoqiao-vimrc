#!ENV/bin/python
# -*- coding: utf-8 -*-

import os
import subprocess
from optparse import OptionParser

HERE = os.path.abspath(os.path.dirname(__file__))
BUNDLE = os.path.join(HERE,'bundle')

GIT_REPOS = (
        'https://github.com/mattn/zencoding-vim',
        'https://github.com/kevinw/pyflakes-vim.git',
        'https://github.com/vim-scripts/NERD_Tree-and-ack.git',
        'https://github.com/vim-scripts/python-imports.vim.git',
        )

def sync():
    for r in GIT_REPOS:
        name = r.strip('/').split('/')[-1]
        path = os.path.join(BUNDLE,name)
        print 'processing %s ...' % name
        if os.path.exists(path):
            op = 'pull'
            cwd = path
        else:
            op = 'clone'
            cwd = BUNDLE
        cmd = 'git %s %s' % (op,r)
        print '%s in %s' % (cmd,cwd)
        subprocess.call(cmd.split(),cwd=cwd)

def main():
    parser = OptionParser()
    parser.add_option("-s", "--sync",
                      action="store_true", dest="sync", default=False,
                      help="sync all repos")

    (options, args) = parser.parse_args()

    if options.sync:
        sync()
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
