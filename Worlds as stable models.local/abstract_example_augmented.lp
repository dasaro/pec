#const maxinstant=5.

fluent(f). boolean(f).
fluent(g). vals(g,a). vals(g,b). vals(g,c).

performed(a,1).
performed(a,3).

initiallyOneOf(1, (f,false)).
initiallyOneOf(1, (g,a)).
probabilityOf(1, frac(9,10) ).

initiallyOneOf(2, (f,true)).
initiallyOneOf(2, (g,a)).
probabilityOf(2, frac(7,100) ).

initiallyOneOf(3, (f,false)).
initiallyOneOf(3, (g,b)).
probabilityOf(3, frac(3,100) ).

2{ causesOneOf(4, ((f,false),I) ); causesOneOf(4, ((g,b),I) ) }2 :-
	world( ((g,a),I) ),
	world( ((a,true),I) ).
probabilityOf(4, frac(9,10) ).

2{ causesOneOf(5, ((f,true),I) ); causesOneOf(5, ((g,b),I) ) }2 :-
	world( ((g,a),I) ),
	world( ((a,true),I) ).
probabilityOf(5, frac(4,100)).

causesOneOf(9, ((F,V),I) ) :-
	fluent(F),
	world( ((F,V),I) ),
	world( ((g,a),I) ),
	world( ((a,true),I) ).
probabilityOf(9, frac(6,100)).

2{ causesOneOf(6, ((f,true),I) ); causesOneOf(6, ((g,c),I) ) }2 :-
	world( ((g,b),I) ),
	world( ((a,true),I) ).
probabilityOf(6, frac(3,6) ).

causesOneOf(7, ((f,true),I) ) :-
	world( ((g,b),I) ),
	world( ((a,true),I) ).
probabilityOf(7, frac(2,6) ).

causesOneOf(8, ((F,V),I) ) :-
	fluent(F),
	world( ((F,V),I) ),
	world( ((g,b),I) ),
	world( ((a,true),I) ).
probabilityOf(8, frac(1,6) ).