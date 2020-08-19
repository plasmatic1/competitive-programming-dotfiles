#!/bin/bash

echo "Cleaning prob.in, prob.out..."
rm -f prob.in prob.out

echo "Copy input... ($1)"
mv $1 ./prob.in

echo "Executing..."
./prog

