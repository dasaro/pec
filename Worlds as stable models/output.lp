#const maxinstant=4.action(a).fluent(f). vals(f, true). vals(f, false). 
fluent(g). vals(g, a). vals(g, b). vals(g, c). 
initiallyOneOf(id0, (f,false)). initiallyOneOf(id0, (g,a)). 
initiallyOneOf(id1, (f,true)). initiallyOneOf(id1, (g,c)). 
causesOneOf(id2, ((f,true),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).

causesOneOf(id2, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ).

causesOneOf(id3,((F,V),I)):-
	world( ((a,true),I) ),
	world( ((f,false),I) ),
	world((F,V),I).
causesOneOf(id4, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).

causesOneOf(id4, ((g,c),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).

causesOneOf(id5, ((f,false),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).

causesOneOf(id6, ((g,a),I)):-
	world( ((a,true),I) ),
	world( ((f,true),I) ).performed(a, 3).
performed(a, 1).