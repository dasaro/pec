{ ../../../Translator/a.out < simpledomain.pec & cat query.lp ../../pec.lp ; } | clingo -n 0 | ../../evaluate.sh
