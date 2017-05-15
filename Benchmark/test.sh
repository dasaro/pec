#!/bin/sh
test_domains_folder="Test_domains/Antibiotic/"
report_dir="Reports/Antibiotic/"
#
installation_path=".."
translator="$installation_path/Translator/bin/translator";
pec_domain_independent="$installation_path/Reasoner/pec.lp";

for f in $test_domains_folder/*
do
{ ../Translator/bin/translator < $f & cat ../Reasoner/pec.lp; } | clingo -n 0 | awk '/^Time/ { total = $3; solving = $5; print total, "\t", solving }' >> Reports/Antibiotic/Total_and_solving_time.txt
done
