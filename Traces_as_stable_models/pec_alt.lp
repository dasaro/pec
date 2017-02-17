instant(0..maxinstant).

action(A) :-
	instant(I),
	performed(A, I).

possVal(X, true) :- boolean(X).
possVal(X, false) :- boolean(X).
boolean(A) :- action(A).
fluentOrAction(X) :- fluent(X).
fluentOrAction(X) :- action(X).

% A literal has the form [X=V] for
% a fluent or an action X and a value
% V such that V \in possVal(F).
literal((X, V)) :-
	fluentOrAction(X),
	possVal(X, V).

% An i-literal has the form [L]@I
% for a literal L and an instant I
iliteral((L, I)) :-
	literal(L),
	instant(I).

% A cause occurs at I in world W iff its
% preconditions are satisfied by W at I
inOcc(I) :-
	instant(I),
	causedOutcome(O, I).

% Worlds are functions from instants to literals
1{ holdsAt(((X, V), I)) : iliteral(((X, V), I)) }1 :-
	fluentOrAction(X),
	instant(I).

% Exactly one state initially hold
1{ initialChoice(O) : initialCondition(O) }1.

% Exactly one partial state is
% activated for each causal occurrence
1{ effectChoice(O, I) : causedOutcome(O, I) }1 :-
	inOcc(I).

% CWA
:- action(A), instant(I), holdsAt( ((A, true),I) ), not performed(A,I).
:- action(A), instant(I), holdsAt( ((A, false),I) ), performed(A,I).

% Persistence
:- initialChoice((S, P)), literal(L), belongsTo(L, S), not holdsAt((L, 0)).

:-	not holdsAt( ((F, V), I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice( (X, P), I),
		belongsTo( (F, V), X ).

:-	holdsAt( ((F, V), I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice( (X, P), I),
		not belongsTo( (F, V), X ),
		not holdsAt( ((F, V),I) ).

:-	instant(I),
		I<maxinstant,
		fluent(F),
		not inOcc(I),
		holdsAt( ((F, V), I) ),
		not holdsAt( ((F, V), I+1) ).


% Calculating probabilities
%probabilityUpTo(0, P) :-
%	initialChoice( (S, P) ).
%
%probabilityUpTo(I+1, P) :-
%	I<maxinstant,
%	not inOcc(I),
%	probabilityUpTo(I, P).
%
%probabilityUpTo(I+1, frac(A*C, B*D)) :-
%	I<maxinstant,
%	inOcc(I),
%	probabilityUpTo(I, frac(A, B)),
%	effectChoice((X, frac(C, D)), I).
%
%probability(P) :-
%	probabilityUpTo(maxinstant, P).

#show initialChoice/1.
#show effectChoice/2.
