% a)
membership(E, [E|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

isSet([]) :- !.
isSet([_]) :- !.
isSet([H1, H2]) :-
    H1 =\= H2,
    !.

isSet([H|T]) :-
    \+ membership(H, T),
    !,
    isSet(T).

% b)
deleteRec([], _, _, []) :- !.
deleteRec(L, _, 0, L) :- !.

deleteRec([H|T], H, Cont, LRez) :-
    !,
    Cont_ is Cont - 1,
    deleteRec(T, H, Cont_, LRez).
deleteRec([H|T], E, Cont, [H|LRez]) :-
    deleteRec(T, E, Cont, LRez).

delete3(L, E, LRez) :-
    deleteRec(L, E, 3, LRez).

