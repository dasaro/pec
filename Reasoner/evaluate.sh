#!/bin/sh

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


/Models/ {
	traces = $3
}

/Time/ {
	asptime = $4
}

END {
	print "============= RESULTS ============="
	print "N. Traces:", traces
	print "P(query) =", result, "\n"
	print "============= EL.TIME ============="
	print "ASP Time:", asptime
}
';
