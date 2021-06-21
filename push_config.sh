#!bash

judges=(dmoj cf sgu fhc unfinished kattis usaco usaco21febplat atcoder lv7 kor kickstart cses mcpt kickstartb ecoo mbit olysummer dmopc20c7)
WINHOME=$(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")

for d in ${judges[@]}; do
    rm -f $d/.template.cpp
    cp .template.cpp $d/.template.cpp
    rm -f -r $d/.cptools
    cp -r .cptools $d/.cptools

    rm -f $d/templates
    ln -s /mnt/e/repos/templates $d/templates
    rm -f $d/downloads
    ln -s $WINHOME/Downloads $d/downloads

    echo "Done $d/"
done
