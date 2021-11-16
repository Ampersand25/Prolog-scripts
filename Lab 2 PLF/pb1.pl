invertListRec([], Col, Col) :- !.

invertListRec([H|T], Col, LInverted) :-
    invertListRec(T, [H|Col], LInverted).

invertList(L, LInverted) :-
    invertListRec(L, [], LInverted).

sumListsInvertedRec([], [], 0, []) :- !.
sumListsInvertedRec([], [], Carry, [Carry]) :- !.

sumListsInvertedRec([H|T], [], Carry, [MOD|LRez]) :-
    !,
    S is H + 0 + Carry,
    MOD is mod(S, 10),
    DIV is div(S, 10),
    sumListsInvertedRec(T, [], DIV, LRez).
sumListsInvertedRec([], [H|T], Carry, [MOD|LRez]) :-
    !,
    S is H + 0 + Carry,
    MOD is mod(S, 10),
    DIV is div(S, 10),
    sumListsInvertedRec(T, [], DIV, LRez).
sumListsInvertedRec([H1|T1], [H2|T2], Carry, [MOD|LRez]) :-
    S is H1 + H2 + Carry,
    MOD is mod(S, 10),
    DIV is div(S, 10),
    sumListsInvertedRec(T1, T2, DIV, LRez).

sumListsInverted(L1, L2, LRez) :-
    sumListsInvertedRec(L1, L2, 0, LRez).

% predicat principal subpunctul a)
sumLists(L1, L2, LSum) :-
    invertList(L1, LInverted1),
    invertList(L2, LInverted2),
    sumListsInverted(LInverted1, LInverted2, LSumInverted),
    invertList(LSumInverted, LSum).

aux([], Col, Col) :- !.

aux([H|T], Col, LRez) :-
    number(H),
    !,
    aux(T, Col, LRez).
aux([H|T], Col, LRez) :-
    % is_list(H),
    sumLists(H, Col, NewCol),
    aux(T, NewCol, LRez).

% predicat principal subpunctul b)
pred(L, LRez) :-
    aux(L, [], LRez).

% testare predicat subpuctul a)
goal :- pred([1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6], [8, 2, 2]).
