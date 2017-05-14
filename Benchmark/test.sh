#!/bin/sh
for f in Test_domains/*
do
{ ../Translator/bin/translator < $f & cat ../Reasoner/pec.lp; } | clingo -n 0 | awk '/^Time/ { total = $3; solving = $5; print total, "\t", solving }' >> Reports/Antibiotic/Total_and_solving_time.txt
done
