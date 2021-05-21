#!bash

judges=(dmoj cf sgu fhc unfinished kattis usaco usaco21febplat atcoder moose20c1 lv7 reply kor dmopc20c4 kickstart gcj cses mcpt kickstartb ecoo)
WINHOME=$(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")

for d in ${judges[@]}; do
    cp .template.cpp $d/.template.cpp
    cp -r .cptools $d/.cptools

    rm -f $d/templates
    rm -f $d/downloads
    ln -s $WINHOME/Dropbox/templates $d/templates
    ln -s $WINHOME/Downloads $d/downloads

    echo "Done $d/"
done
