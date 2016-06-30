instant(0..maxinstant).

truthvalue(true). truthvalue(false).

action(A) :-
	instant(I),
	performed(A,I).

vals(X,V) :- boolean(X), truthvalue(V).

boolean(A) :- action(A).

fluentOrAction(X) :- fluent(X).
fluentOrAction(X) :- action(X).

% A literal has the form [X=V] for
% a fluent or an action X and a value
% V such that V \in vals(F).
literal( (X,V) ) :-
	fluentOrAction(X),
	vals(X,V).

% An i-literal has the form [L]@I
% for a literal L and an instant I
iliteral( (L,I) ) :-
	literal(L),
	instant(I).

% Identifiers are used to group effects
% of actions.
identifier(ID) :-
	causesOneOf(ID,IL),
	iliteral(IL).

% A cause occurs at I in world W iff its
% preconditions are satisfied by W at I
occ(I) :-
	identifier(ID),
	iliteral((L,I)),
	causesOneOf(ID,(L,I)).

% Worlds are functions from instants to literals
1{ world( IL ) : iliteral( IL ), IL=((X,V),I) }1 :-
	fluentOrAction(X),
	instant(I).

% Exactly one set of initial conditions hold
1{ initialChoice( ID ) : initiallyOneOf(ID,L), literal(L) }1.

% Exactly one set of effects are activated for each
% cause occurrence
1{ effectChoice( ID, I ) : causesOneOf(ID,IL), iliteral(IL), IL=(L,I) }1 :-
	occ(I).

%CWA
:- action(A), instant(I), world( ((A,true),I) ), not performed(A,I).
:- action(A), instant(I), world( ((A,false),I) ), performed(A,I).

%Persistence
world( (L,0) ) :-
	initiallyOneOf(ID,L),
	initialChoice(ID).

world( ((F,V),I+1) ) :-
	instant(I),
	I<maxinstant,
	fluent(F),
	effectChoice(ID,I),
	causesOneOf(ID,((F,V),I)).

world( ((F,V),I+1) ) :-
	instant(I),
	I<maxinstant,
	fluent(F),
	not occ(I),
	world( ((F,V),I) ).

#show world/1.
#show effectChoice/2.