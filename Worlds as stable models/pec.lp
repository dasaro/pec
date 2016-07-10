instant(0..maxinstant).

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

% A cause occurs at I in world W iff its
% preconditions are satisfied by W at I
occ(I) :-
	instant(I),
	causesOutcome(X, I).

% Worlds are functions from instants to literals
1{ world( IL ) : iliteral( IL ), IL=((X,V),I) }1 :-
	fluentOrAction(X),
	instant(I).

% Exactly one state initially hold
1{ initialChoice(S) : initialState(S) }1.

% Exactly one partial state is
% activated for each causal occurrence
1{ effectChoice( X, I ) : causesOutcome(X,I) }1 :-
	occ(I).

%CWA
:- action(A), instant(I), world( ((A,true),I) ), not performed(A,I).
:- action(A), instant(I), world( ((A,false),I) ), performed(A,I).

%Persistence
:- initialChoice(S), literal(L), belongsTo(L,S), not world((L,0)).

:-	not world( ((F,V),I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice(X,I),
		belongsTo( (F,V), X ).

:-	world( ((F,V),I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice(X,I),
		not belongsTo( (F,V), X ),
		not world( ((F,V),I) ).

:-	instant(I),
		I<maxinstant,
		fluent(F),
		not occ(I),
		world( ((F,V),I) ),
		not world( ((F,V),I+1) ).

% Calculating probabilities
probabilityUpTo(0, frac(W,Z) ) :-
	initialChoice(S),
	probabilityOf(S, frac(W,Z) ).

probabilityUpTo(I+1, frac(W,Z) ) :-
	I<maxinstant,
	not occ(I),
	probabilityUpTo(I, frac(W,Z) ).

probabilityUpTo(I+1, frac(W,Z) ) :-
	I<maxinstant,
	occ(I),
	probabilityUpTo(I, frac(A,B) ),
	effectChoice(X, I),
	probabilityOf(X, frac(C,D) ),
	W = A*C,
	Z = B*D.

probability( frac(W,Z) ) :-
	probabilityUpTo(maxinstant, frac(W,Z) ).

#show initialChoice/1.
#show effectChoice/2.
#show probability/1.
