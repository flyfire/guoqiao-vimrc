#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import subprocess
from optparse import OptionParser

HERE = os.path.abspath(os.path.dirname(__file__))
BUNDLE = os.path.join(HERE,'bundle')
LIST = os.path.join(HERE,'bundle.txt')

def clone():
    for line in open(LIST):
        line = line.strip()
        if not line:
            continue
        if line.startswith('#'):
            continue
        cmd = 'git clone -v %s' % (line,)
        print cmd
        subprocess.call(cmd.split(),cwd=BUNDLE)

def pull():
    for name in os.listdir(BUNDLE):
        path = os.path.join(BUNDLE,name)
        if os.path.isdir(path):
            print 'pull %s ...' % name
            cmd = 'git pull -v '
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
