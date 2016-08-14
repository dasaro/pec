translator="/Users/dasaro/Desktop/pec-git/Translator/a.out";
pec_domain_independent="/Users/dasaro/Desktop/pec-git/Worlds_as_stable_models/pec.lp";
evaluation_script="/Users/dasaro/Desktop/pec-git/Worlds_as_stable_models/evaluate.sh";

read -e -p "Enter PEC domain description: " pec_domain_description
read -e -p "Enter query file (optional): " query_file
if [ -n "$query_file" ]; then
  { "$translator" < "$pec_domain_description" & cat "$query_file" "$pec_domain_independent"; } | clingo -n 0 | "$evaluation_script"
else
  { "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0
fi
