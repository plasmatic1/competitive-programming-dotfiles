#!bash

judges=(dmoj cf sgu fhc unfinished uwacm kattis usaco usaco21janplat atcoder moose20c1 lv7 dmopc20c3)
WINHOME=$(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")

for d in ${judges[@]}; do
    cp .template.cpp $d/.template.cpp
    cp -r .cptools $d/.cptools

    rm -f $d/templates
    ln -s $WINHOME/Dropbox/templates $d/templates

    echo "Done $d/"
done
