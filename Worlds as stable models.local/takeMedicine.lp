#const maxinstant=2.

fluent(hasFlu). boolean(hasFlu).
fluent(hasBlueSkin). boolean(hasBlueSkin).
action(takeMedicine).

performed(takeMedicine,1).

initiallyOneOf( id1, (hasFlu,true) ).
initiallyOneOf( id1, (hasBlueSkin,false) ).

initiallyOneOf( id2, (hasFlu,false) ).
initiallyOneOf( id2, (hasBlueSkin,false) ).

2{ causesOneOf( id3, ((hasFlu,false),I) ); causesOneOf( id3, ((hasBlueSkin,true),I) ) }2 :-
	performed(takeMedicine,I),
	world( ((hasFlu,true),I) ).
