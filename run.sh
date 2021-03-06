#!/bin/bash

# INSTALLATION PATH:
# It is set to the directory this script is located in
INSTALLATION_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# BINARIES LOCATION
# Use evaluation_script="$INSTALLATION_PATH/Traces_as_stable_models/evaluate_alt.sh";
# and pec_domain_independent="$INSTALLATION_PATH/Traces_as_stable_models/pec_alt.lp";
# if the independent part of pec supports autonomous probability evaluation
translator="$INSTALLATION_PATH/Translator/bin/translator";
pec_domain_independent="$INSTALLATION_PATH/Reasoner/pec.lp";
evaluation_script="$INSTALLATION_PATH/Reasoner/evaluate.sh";

#
# RUN PEC
#
read -e -p "Locate PEC domain description: " pec_domain_description
read -e -p "Locate query file (optional): " query_file
if [ -n "$query_file" ]; then
  # Output models and then post-processes traces to get a probability
  { cat "$query_file" & "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0 | "$evaluation_script"
  # TO DISPLAY TRACES UNCOMMENT FOLLOWING LINE:
  #{ cat "$query_file" & "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0 | tee /dev/tty | "$evaluation_script"
else
  { "$translator" < "$pec_domain_description" & cat "$pec_domain_independent"; } | clingo -n 0
fi
