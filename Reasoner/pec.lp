instant(0..maxinstant).

action(A) :-
	instant(I),
	possiblyPerformed(A, I).

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
1{ holds(((X, V), I)) : iliteral(((X, V), I)) }1 :-
	fluentOrAction(X),
	instant(I).

% Exactly one state initially hold
1{ initialChoice(O) : initialCondition(O) }1.

% Exactly one partial state is
% activated for each causal occurrence
1{ effectChoice(O, I) : causedOutcome(O, I) }1 :-
	inOcc(I).

% Auxiliary predicates for CWA
possiblyPerformed(A,I) :-
	performed(A,I, frac(X,Y)),
	X <= Y.

definitelyPerformed(A,I) :-
		performed(A,I, frac(X,X)),
		X>0.

% Closed World Assumption
:- action(A), instant(I), holds( ((A, false),I) ), definitelyPerformed(A,I).
:- action(A), instant(I), holds( ((A, true),I) ), not possiblyPerformed(A,I).

% Initial Condition
:- initialChoice((S, P)), literal(L), belongsTo(L, S), not holds((L, 0)).

% Justified Change
:-	not holds( ((F, V), I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice( (X, P), I),
		belongsTo( (F, V), X ).

% Minimal Change
:-	holds( ((F, V), I+1) ),
		instant(I),
		I<maxinstant,
		fluent(F),
		effectChoice( (X, P), I),
		not belongsTo( (F, V), X ),
		not holds( ((F, V),I) ).

% Persistence
:-	instant(I),
		I<maxinstant,
		fluent(F),
		not inOcc(I),
		holds( ((F, V), I) ),
		not holds( ((F, V), I+1) ).

% Evaluation of narrative
eval(A,I,P) :- action(A), instant(I), performed(A,I,P), holds( ((A,true),I) ).
eval(A,I,frac(X2,Y)) :- action(A), instant(I), performed(A,I,frac(X1,Y)), holds( ((A,false),I) ), X2 = Y - X1.

#show initialChoice/1.
#show effectChoice/2.
#show eval/3.
