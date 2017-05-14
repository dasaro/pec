#!/bin/sh
for i in $(seq -f %003g 1 999)
do
    cp seed.pec Test_domains/test_$i.pec
done

i=0
for f in Test_domains/*
do
    ((i++))
    for ((j=0; j<=i*25; j=j+5))
    do
        echo "takesMedicine performed-at $j" >> $f
    done
done
