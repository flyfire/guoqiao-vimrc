#!ENV/bin/python
# -*- coding: utf-8 -*-

import os
import subprocess
from optparse import OptionParser

HERE = os.path.abspath(os.path.dirname(__file__))
BUNDLE = os.path.join(HERE,'bundle')

GIT_REPOS = (
        'https://github.com/mattn/zencoding-vim',
        )

def fetch():
    for r in GIT_REPOS:
        name = r.strip('/').split('/')[-1]
        path = os.path.join(BUNDLE,name)
        print 'processing %s ...' % name
        if os.path.exists(path):
            op = 'pull'
            cwd = path
        else:
            op = 'clone'
            cwd = HERE
        cmd = 'git %s %s' % (op,r)
        print '%s in %s' % (cmd,cwd)
        subprocess.call(cmd.split(),cwd=cwd)

def main():
    parser = OptionParser()
    parser.add_option("-f", "--fetch",
                      action="store_true", dest="fetch", default=False,
                      help="fetch all repos")

    (options, args) = parser.parse_args()

    if options.fetch:
        fetch()
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
