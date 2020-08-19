#!python3

import shutil
import sys
import os

IGNORE = set(['test.cpp', 'test.yml', 'template.cpp', 'cp_tools_console.egg-info', 'move.py', 'open.sh', 'gen.py'])

dirname = sys.argv[1]
in_dirname = dirname + '/inputs'
os.mkdir(dirname)
os.mkdir(in_dirname)

for f in os.listdir('.'):
    if f in IGNORE or os.path.isdir(f): continue

    n, ext = os.path.splitext(f)
    if ext == '.yml':
        shutil.move(f, f'{in_dirname}/{f}')
    else:
        shutil.move(f, f'{dirname}/{f}')
