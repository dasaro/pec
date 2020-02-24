#!/bin/sh
test_domains_folder="Test_domains/Decay-Frontiers/"
report_dir="Reports/Decay-Frontiers/"
#
installation_path=".."
translator="$installation_path/Translator/bin/translator";
pec_domain_independent="$installation_path/Reasoner/pec.lp";

for f in $test_domains_folder/*
do
{ "$translator" < "$f" & cat "$pec_domain_independent"; } | clingo -n 0 | awk '/^Models/ { traces = $3 } /^Time/ { total = $3; solving = $5; } END { print traces, "\t", total, "\t", solving }' >> $report_dir/traces_tab_total_tab_solving.txt
done
