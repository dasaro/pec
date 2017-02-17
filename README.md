# PEC ASP Implementation v0.1

The Probabilistic Event Calculus (PEC) is a probabilistic extension of a popular framework for reasoning about the effects of a narrative of action occurrences (events) along a time line known as the [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) (EC).

This repository hosts an [ASP](https://en.wikipedia.org/wiki/Answer_set_programming) Implementation of PEC able to perform temporal projection.

# How to compile

To compile the translator, you will need the two tools [flex](https://github.com/westes/flex) and [Bison](https://www.gnu.org/software/bison/), together with [gcc](https://gcc.gnu.org).

The translator can be compiled using the following command:

``` sh
bison -d grammar.y; flex lexer.l; gcc dynamicarray.c lex.yy.c grammar.tab.c -o bin/translator
```
