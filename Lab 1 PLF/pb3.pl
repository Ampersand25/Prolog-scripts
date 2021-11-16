% a)
membership(E, [E|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

toSetRec([], _, []) :- !.

toSetRec([H|T], Col, LRez) :-
    membership(H, Col),
    !,
    toSetRec(T, Col, LRez).
toSetRec([H|T], Col, [H|LRez]) :-
    toSetRec(T, [H|Col], LRez).

toSet(L, LSet) :-
    toSetRec(L, [], LSet).

go :- toSet([1, 2, 3, 1, 2], [1, 2, 3]).

% b)
oddEven([], [], [], 0, 0) :- !.
oddEven([H|[]], [H], [], 1, 0) :-
    MOD is mod(H, 2),
    MOD =\= 0, % MOD \= 0
    %MOD == 1, % MOD = 1
    !.
oddEven([H], [], [H], 0, 1) :- !.

oddEven([H|T], OddL, [H|EvenL], OddNumber, EvenNumber) :-
    MOD is mod(H, 2),
    MOD == 0, % MOD = 0
    !,
    oddEven(T, OddL, EvenL, OddNumber, EvenNumber_),
    EvenNumber is EvenNumber_ + 1.
oddEven([H|T], [H|OddL], EvenL, OddNumber, EvenNumber) :-
    !,
    oddEven(T, OddL, EvenL, OddNumber_, EvenNumber),
    OddNumber is OddNumber_ + 1.

oddEvenGen(L, [LPare, LImpare], NrPare, NrImpare) :-
    oddEven(L, LImpare, LPare, NrImpare, NrPare).

