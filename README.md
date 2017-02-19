# PEC-ASP v0.1

The Probabilistic Event Calculus (PEC) is a probabilistic extension of a popular framework for reasoning about the effects of a narrative of action occurrences (events) along a time line known as the [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) (EC).

This repository hosts an [ASP](https://en.wikipedia.org/wiki/Answer_set_programming) Implementation of PEC able to perform temporal projection.

# How to compile and run

To compile the translator, you will need the two tools [flex](https://github.com/westes/flex) and [Bison](https://www.gnu.org/software/bison/), together with [gcc](https://gcc.gnu.org).

The translator can be compiled by changing directory to the `Translator` directory in the installation path, and then using the following command:

``` sh
bison -d grammar.y; flex lexer.l; gcc dynamicarray.c lex.yy.c grammar.tab.c -o bin/translator
```

Provided binaries are for OSX.

## Running the translator

If you want to run the translator alone, then use
``` sh
./Translator/bin/translator < inputDomain.pec > output.lp
```
from the installation path, where `inputDomain.pec` is the file you want to translate, and `output.lp` is the output file.

## Running PEC-ASP

Make sure that you have [Clingo](http://potassco.sourceforge.net) correctly installed. Then, PEC can be run using the command
``` sh
./run.sh
```

If the installation path is not detected correctly, change the variable `INSTALLATION_PATH` in `run.sh` to match the directory where PEC is installed to.

## Execution Example

The following is an execution example:

``` sh
$ ./run.sh
Locate PEC domain description: Examples/Antibiotic/antibiotic.pec
Locate query file (optional): Examples/Antibiotic/query.lp
============= RESULTS =============
N. Traces: 1
P(query) = 0.0830769

============= EL.TIME =============
ASP Time: 0.000s
Total Time: 0m0s
```

The other examples in the `$INSTALLATION_PATH/Examples` folder can be run in a similar way.
