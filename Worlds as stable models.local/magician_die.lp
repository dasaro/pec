#const maxinstant=5.

fluent(die). 	vals(die,face1). vals(die,face2).
		vals(die,face3). vals(die,face4).
		vals(die,face5). vals(die,face6).

performed(throw,0).
performed(magic_throw,1).
performed(magic_throw,2).

initiallyOneOf(id1, (die,face6)).
initiallyOneOf(id2, (die,face1)).

causesOneOf(V, ((die,V),I) ) :-
	vals(die,V),
	performed(throw,I).

causesOneOf(V, ((die,V),I) ) :-
	vals(die,V),
	not V=face6,
	not V=face1,
	performed(magic_throw,I).