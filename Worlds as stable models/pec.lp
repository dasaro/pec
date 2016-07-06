instant(0..maxinstant).

probabilityUpTo(0, frac(X,Y) ) :-
	initialChoice(ID),
	probabilityOf(ID, frac(X,Y) ).

probabilityUpTo(I, frac(X,Y) ) :-
	I<=maxinstant,
	not occ(I-1),
	probabilityUpTo(I-1, frac(X,Y) ).

probabilityUpTo(I, frac(X,Y) ) :-
	I<=maxinstant,
	occ(I-1),
	probabilityUpTo(I-1, frac(A,B) ),
	effectChoice(ID, I-1),
	probabilityOf(ID, frac(C,D) ),
	X = A*C,
	Y = B*D.

probability( frac(X,Y) ) :-
	probabilityUpTo(maxinstant, frac(X,Y) ).

action(A) :-
	instant(I),
	performed(A,I).

possVal(X,true) :- boolean(X).
possVal(X,false) :- boolean(X).
boolean(A) :- action(A).
fluentOrAction(X) :- fluent(X).
fluentOrAction(X) :- action(X).

% A literal has the form [X=V] for
% a fluent or an action X and a value
% V such that V \in possVal(F).
literal( (X,V) ) :-
	fluentOrAction(X),
	possVal(X,V).

% An i-literal has the form [L]@I
% for a literal L and an instant I
iliteral( (L,I) ) :-
	literal(L),
	instant(I).

% Identifiers are used to group effects
% of actions.
identifier(ID) :-
	causesOutcome(ID,IL),
	iliteral(IL).

% A cause occurs at I in world W iff its
% preconditions are satisfied by W at I
occ(I) :-
	identifier(ID),
	iliteral((L,I)),
	causesOutcome(ID,(L,I)).

% Worlds are functions from instants to literals
1{ world( IL ) : iliteral( IL ), IL=((X,V),I) }1 :-
	fluentOrAction(X),
	instant(I).

% Exactly one set of initial conditions hold
1{ initialChoice( ID ) : initialState(ID,L), literal(L) }1.

% Exactly one set of effects are activated for each
% cause occurrence
1{ effectChoice( ID, I ) : causesOutcome(ID,IL), iliteral(IL), IL=(L,I) }1 :-
	occ(I).

%CWA
:- action(A), instant(I), world( ((A,true),I) ), not performed(A,I).
:- action(A), instant(I), world( ((A,false),I) ), performed(A,I).

%Persistence
:-	initialState(ID,L),
	initialChoice(ID),
	not world((L,0)).

:-	not world( ((F,V),I+1) ),
	instant(I),
	I<maxinstant,
	fluent(F),
	effectChoice(ID,I),
	causesOutcome(ID,((F,V),I)).

:-	not world( ((F,V),I+1) ),
	instant(I),
	I<maxinstant,
	fluent(F),
	not occ(I),
	world( ((F,V),I) ).

#show probability/1.
#show initialChoice/1.
#show effectChoice/2.
