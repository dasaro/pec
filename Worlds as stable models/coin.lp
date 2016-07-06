#const maxinstant=2.

fluent(coin). vals(coin,heads). vals(coin,tails).

performed(toss,0).

initiallyOneOf(id1, (coin,heads)).
initiallyOneOf(id2, (coin,tails)).

causesOneOf(id3, ((coin,heads),I) ) :-
	world( ((toss,true),I) ).

causesOneOf(id4, ((coin,tails),I) ) :-
	world( ((toss,true),I) ).