fluent(f). vals(f, true). vals(f, false). 
fluent(g). vals(g, a). vals(g, b). vals(g, c). 
initiallyOneOf(id0, (f,false)).
initiallyOneOf(id0, (g,a)).
probabilityOf(id0, frac(8,10)).

initiallyOneOf(id1, (f,true)).
initiallyOneOf(id1, (g,c)).
probabilityOf(id1, frac(2,10)).

causesOneOf(id2, ((f,true),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
causesOneOf(id2, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).
probabilityOf(id2, frac(1,10)).

causesOneOf(id3,((F,V),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ),
	world( ((F,V),I) ).
probabilityOf(id3, frac(9,10)).

causesOneOf(id4, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
causesOneOf(id4, ((g,c),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id4, frac(1,10)).

causesOneOf(id5, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id5, frac(85,100)).

causesOneOf(id6, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).
probabilityOf(id6, frac(5,100)).

performed(a, 3).
performed(a, 1).

#const maxinstant=3.