#!/bin/sh

#
# INSTALLATION PATH:
# It is set to the directory this script is located in
INSTALLATION_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# BINARIES LOCATION
# Use evaluation_script="$INSTALLATION_PATH/Worlds_as_stable_models/evaluate_alt.sh";
# and pec_domain_independent="$INSTALLATION_PATH/Worlds_as_stable_models/pec_alt.lp";
# if the independent part of pec supports autonomous probability evaluation
translator="$INSTALLATION_PATH/Translator/bin/translator";
pec_domain_independent="$INSTALLATION_PATH/Worlds_as_stable_models/pec_alt.lp";
evaluation_script="$INSTALLATION_PATH/Worlds_as_stable_models/evaluate_alt.sh";

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
