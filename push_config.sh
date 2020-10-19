#!bash

judge=(dmoj cf sgu fhc unfinished)

for d in ${judge[@]}; do
    cp .template.cpp $d/.template.cpp
    cp -r .cptools $d/.cptools
    echo "Done $d/"
done

