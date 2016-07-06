fluent(f). possVal(f, true). possVal(f, false). 
fluent(g). possVal(g, a). possVal(g, b). possVal(g, c). possVal(g, d). possVal(g, e). possVal(g, f). possVal(g, g). possVal(g, h). 
initialState(id0, (f,false)).
initialState(id0, (g,a)).
probabilityOf(id0, frac(8,10)).

initialState(id1, (f,true)).
initialState(id1, (g,c)).
probabilityOf(id1, frac(2,10)).

causesOutcome(id2, ((f,true),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
causesOutcome(id2, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
probabilityOf(id2, frac(1,10)).

causesOutcome(id3,((F,V),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ),
	world( ((F,V),I) ).
probabilityOf(id3, frac(9,10)).

causesOutcome(id4, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
causesOutcome(id4, ((g,c),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id4, frac(1,10)).

causesOutcome(id5, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id5, frac(85,100)).

causesOutcome(id6, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id6, frac(5,100)).

performed(a, 3).
performed(a, 1).

#const maxinstant=3.