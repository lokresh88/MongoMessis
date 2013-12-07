#!/bin/bash


for wc in 10 20 30 40 50 60 70 80 90 100
do
	for w in 10000
	do
		./runExp.sh $w $wc 1
	done
done

