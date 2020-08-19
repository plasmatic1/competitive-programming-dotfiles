#!/bin/bash
echo "Make template..."
echo "// $1.yml" >$1.cpp
cat template.cpp >>$1.cpp
echo "Make yml..."
cp template.yml $1.yml
chmod +x $1.yml
