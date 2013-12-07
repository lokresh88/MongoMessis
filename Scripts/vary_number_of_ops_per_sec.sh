#!/bin/bash


for wc in 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000
do
	for w in 10
	do
		./runExp.sh $wc $w 1
	done
done

