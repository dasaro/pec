#!/bin/sh

# DROPBOX LOCATION
DROPBOX_IMPLEMENTATION_PATH=$(python -c "import json;f=open('$HOME/.dropbox/info.json', 'r').read();data=json.loads(f);print data.get('personal', {}).get('path', '')")/FabioPhDsupervision/PEC_Paper/pec-implementation/

# BINARIES LOCATION
# Use evaluation_script="/Users/dasaro/Desktop/pec-git/Worlds_as_stable_models/evaluate2.sh";
# if the independent part of pec supports autonomous probability evaluation
translator="/Users/dasaro/Desktop/pec-git/Translator/bin/translator";
pec_domain_independent="/Users/dasaro/Desktop/pec-git/Worlds_as_stable_models/pec.lp";
evaluation_script="/Users/dasaro/Desktop/pec-git/Worlds_as_stable_models/evaluate2.sh";


#
# RUN PEC
#
read -e -p "Locate PEC domain description: " pec_domain_description
read -e -p "Locate query file (optional): " query_file
if [ -n "$query_file" ]; then
  { cat "$query_file" & "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0 | "$evaluation_script"
else
  { "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0
fi
