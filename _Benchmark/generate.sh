#!/bin/bash
seed_file="seed.pec"
test_domains_folder="Test_domains/Decay-Frontiers/"

for i in $(seq -f %003g 1 50)
do
    cp "$seed_file" "$test_domains_folder/test_$i.pec"
done

i=0
for f in $test_domains_folder/*
do
    ((i++))
    for ((j=0; j<i; j++))
    do
        echo "a performed-at $j with-prob $(awk "BEGIN{printf int(100000/($j+1))}")/100000" >> $f
    done
done
