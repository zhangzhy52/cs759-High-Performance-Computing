#!/bin/bash
size_image=1024
size_pattern=9

for i in `seq 1 40`;
do
	#./problem1.exe $i >> result1
	./problem2.exe $i $size_image $size_pattern >> result2
done