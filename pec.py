import argparse
import clingo
import subprocess

translator_bin = "Translator/bin/translator"
pec_domain_independent = "pec.lp"

def main():
    
	# PARSE COMMAND LINE INPUT
    parser = argparse.ArgumentParser()
    parser.add_argument('filename', help='path to the input file', type=str)
    parser.add_argument('-q', '--query', help='runs PEC on the specified query', default="", type=str)
    args = parser.parse_args()
    # END INPUT HANDLING
    
    main = clingo.Control()
    main.configuration.solve.models = 0
    translated_domain = (subprocess.run("%s < %s" % (translator_bin,args.filename), shell=True, stdout=subprocess.PIPE)).stdout.decode("utf-8")    
    main.load(pec_domain_independent)
    main.add("base", [], translated_domain)
    
    if (args.query != ""):
        main.load(args.query)
    
    main.ground([("base", [])])
    
    with main.solve(yield_=True) as handle:
        total_prob = 0
        for m in handle:
            current_trace_prob = 1
            for t in m.symbols(atoms=True):
                if (t.name=="effectChoice") or (t.name=="initialChoice"):
                    num = float(str(t.arguments[0].arguments[1].arguments[0]))
                    den = float(str(t.arguments[0].arguments[1].arguments[1]))
                    current_trace_prob = current_trace_prob * num/den
                elif (t.name=="eval"):
                    num = float(str(t.arguments[2].arguments[0]))
                    den = float(str(t.arguments[2].arguments[1]))
                    current_trace_prob = current_trace_prob * num/den
                    
                    
            total_prob = total_prob + current_trace_prob

    print(total_prob)

# CALLS MAIN FUNCTION
if __name__ == "__main__":
	main()
