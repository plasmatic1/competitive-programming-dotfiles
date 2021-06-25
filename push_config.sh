#!bash

judges=(dmoj cf sgu fhc unfinished kattis usaco atcoder kor cses mcpt)

for d in ${judges[@]}; do
    rm -f $d/.template.cpp
    cp .template.cpp $d/.template.cpp
    rm -f -r $d/.cptools
    cp -r .cptools $d/.cptools

    rm -f $d/templates
    cp -P templates $d/templates
    rm -f $d/downloads
    cp -P downloads $d/downloads

    echo "Done $d/"
done
