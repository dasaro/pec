--------------------+
Experiment details: |
--------------------+

MACHINE: Dell Inspiron 15 5000 Series

IMPLEMENTATION: PEC-ASP (simulation of an online variant)

COMMENTS:

This is the same as Experiment 1, except that an "online" version of the framework was simulated. As it is clear from the data, this version dramatically reduces total solving time even in the case of the "exact" version of the implementation (which is the one being tested here). The principle is that what is known about fluents at a given instant is compiled into new i-proposition, which is then recursively constructed at every subsequent instant. However, it should be noted that the time for constructing the new i-proposition is not being taken into account here (they were constructed manually). This is to be explored further on. My expectation is that it will take long to construct the i-prop for domains with many fluents (as the number of entries in the i-prop is 2^|F|).

