fluent(f). possVal(f, true). possVal(f, false).
fluent(g). possVal(g, a). possVal(g, b). possVal(g, c).

partialstate(id0).
belongsTo( (f,false), id0 ).
belongsTo((g,a), id0).
initialState(id0).
probabilityOf(id0, frac(1,1)).

partialstate(id1).
belongsTo( (f,true), id1 ).
belongsTo( (g,b), id1 ).
causesOutcome(id1,I) :-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
probabilityOf(id1, frac(7,10)).

partialstate(id2).
belongsTo( (g,c), id2 ).
causesOutcome(id2,I) :-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
probabilityOf(id2, frac(1,10)).

partialstate(id3).
causesOutcome(id3,I) :-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
probabilityOf(id3, frac(2,10)).

performed(a, 1).

#const maxinstant=2.
