#!bash

judges=(dmoj cf sgu fhc unfinished kattis usaco atcoder kor cses mcpt)

for d in ${judges[@]}; do
    cp -f .template.cpp $d/.template.cpp
    cp -f -r .cptools $d/.cptools

    cp -f -P templates $d/templates
    cp -f -P downloads $d/downloads

    echo "Done $d/"
done
