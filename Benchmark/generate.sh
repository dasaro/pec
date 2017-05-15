#!/bin/sh
seed_file="seed.pec"
test_domains_folder="Test_domains/Antibiotic/"

for i in $(seq -f %003g 1 99)
do
    cp "$seed_file" "$test_domains_folder/test_$i.pec"
done

i=0
for f in $test_domains_folder/*
do
    ((i++))
    for ((j=0; j<i; j++))
    do
        echo "takesMedicine performed-at $j with-prob 2/3" >> $f
    done
done
