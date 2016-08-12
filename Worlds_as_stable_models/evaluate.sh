#!/bin/sh
awk '
BEGIN { result=0 }
{
	for (i=1; i<=NF; i++) {
		if ($i ~ "probability") {
			comma_pos = index($i, ",")

			num = substr($i, 18, comma_pos-18)
			den = substr($i, comma_pos+1, length($i)-comma_pos-2)

			result = result + num/den
		}
	}
}
END {
	print "P(query) = ", result
}
'
