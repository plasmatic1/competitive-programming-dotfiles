#!/bin/bash
# $1 -> problem name (i.e. A, B, C, D1, D2)

echo "Moving $1..."
mv $1.cpp fhc
mv $1.yml fhc
echo "Removing test data and executable..."
rm -f prob.in prob.out prog

