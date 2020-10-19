#!bash

judges=(dmoj cf sgu fhc unfinished)
WINHOME=$(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")

for d in ${judges[@]}; do
    cp .template.cpp $d/.template.cpp
    cp -r .cptools $d/.cptools

    rm -f $d/templates
    ln -s $WINHOME/Dropbox/templates $d/templates

    echo "Done $d/"
done
