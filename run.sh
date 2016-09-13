#!/bin/sh

#
# INSTALLATION PATH:
# If the variable DROPBOX_INSTALLATION_PATH is set, the script
# will use that as installation path. Comment out the variable
# to use OTHER_INSTALLATION_PATH as installation path.
#

# DROPBOX:
# DROPBOX_INSTALLATION_PATH="$(python -c "import json;f=open('$HOME/.dropbox/info.json', 'r').read();data=json.loads(f);print data.get('personal', {}).get('path', '')")/FabioPhDsupervision/PEC_Paper/pec-implementation"

# OTHER PATH:
OTHER_INSTALLATION_PATH="/Users/dasaro/Desktop/pec-git"

if [ -n $DROPBOX_INSTALLATION_PATH ]; then
  INSTALLATION_PATH=$DROPBOX_INSTALLATION_PATH
  echo "\nUSING DROPBOX INSTALL: $INSTALLATION_PATH\n"
else
  INSTALLATION_PATH=$OTHER_INSTALLATION_PATH
  echo "\nUSING INSTALLATION PATH: $INSTALLATION_PATH\n"
fi

# BINARIES LOCATION
# Use evaluation_script="Worlds_as_stable_models/evaluate2.sh";
# if the independent part of pec supports autonomous probability evaluation
translator="$INSTALLATION_PATH/Translator/bin/translator";
pec_domain_independent="$INSTALLATION_PATH/Worlds_as_stable_models/pec.lp";
evaluation_script="$INSTALLATION_PATH/Worlds_as_stable_models/evaluate2.sh";

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
