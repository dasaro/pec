#!/bin/sh
######################################################################
aux_files="Aux"
query_file="$aux_files/query.lp"
#
installation_path=".."
translator="$installation_path/Translator/bin/translator";
pec_domain_independent="$installation_path/Reasoner/pec.lp";
evaluation_script="$installation_path/Reasoner/evaluate.sh";
#
last_instant=12
domain_description="../Examples/AVATEA/Experiment9/avatea.pec"
report_dir="Reports/AVATEA/Experiment9"
report_file="taskCorrect.txt"
query="(taskCorrect,true)"
######################################################################

echo "Query: holds(($query,I)) for I=0,...,$last_instant."
echo "OPENING FILE $domain_description"
echo "WRITING TO $report_file in directory $report_dir. \n"
echo "Query: holds(($query,I)) for I=0,...,$last_instant. \n" > $report_dir/$report_file;
echo "Inst\tProb\tTraces\tT.Time\tS.Time\tCPU Time " >> $report_dir/$report_file;

for i in $(seq 0 $last_instant)
do
	echo "holds(($query,$i))." > $query_file;
	echo "Executing query: holds(($query,$i))..."
	{ cat "$query_file" & "$translator" < "$domain_description" & cat "$pec_domain_independent"; } | clingo -n 0 | "$evaluation_script" | awk -v i="$i" '/^N. Traces/ { traces = $3 } /^Time/ { total_time = $2; solving_time = $4 } /^CPU Time/ { cpu_time = $3 } /^P\(query\)/ { prob = $3 } END { print i, "\t", prob, "\t", traces, "\t", total_time, "\t", solving_time, "\t", cpu_time }' >> $report_dir/$report_file;

done

