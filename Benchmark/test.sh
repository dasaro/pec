#!/bin/sh
for f in Test_domains/*
do
    SECONDS=0
    { ../Translator/bin/translator < $f & cat ../Reasoner/pec.lp; } | clingo -n 0 &> /dev/null
    echo "$SECONDS" >> Reports/report.txt
done
