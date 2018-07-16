#!/bin/sh
SECONDS=0
awk '
BEGIN {
				result=0
			}

/Choice/ {
	trace_prob = 1;
	narr_prob = 1;

	for (i=1; i<=NF; i++) {
		if ($i ~ /Choice\(/) {
			split( $i, z, "[(),]")

			num = z[5];
			den = z[6];

			trace_prob = trace_prob * num/den
		}

		if ($i ~ /eval\(/) {
			split( $i, z, "[(),]")

			num = z[5];
			den = z[6];

			narr_prob = narr_prob * num/den
		}

	}
	result = result + (trace_prob * (narr_prob))
}


/^Models/ {
	traces = $3
}

/^Time/ {
	total_time = $3
	solving_time = $5
}
/^CPU Time/ {
	cpu_time = $4
}

END {
	print "============= RESULTS =============="
	print "N. Traces:", traces
	print "P(query) =", result, "\n"
	
	print "============= ASP TIME ============="
	print "Time: ", total_time, "(Solving:", solving_time ,")"
	print "CPU Time: ", cpu_time, "\n"
}
';

echo "============= TOTAL ================"
echo "Total Time: $(($SECONDS / 60))m$(($SECONDS % 60))s"
