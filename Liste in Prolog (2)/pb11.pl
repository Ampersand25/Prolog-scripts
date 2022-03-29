primRec(N, N) :- !.

primRec(N, Div) :-
    N =\= 1,
    mod(N, Div) =\= 0,
    !,
    DivPlus is Div + 1,
    primRec(N, DivPlus).

prim(2) :- !.

prim(N) :-
    primRec(N, 2).

dupPrims([], []).

dupPrims([H|T], [H|[H|LRez]]) :-
    prim(H),
    !,
    dupPrims(T, LRez).
dupPrims([H|T], [H|LRez]) :-
    dupPrims(T, LRez).

pred([], []) :- !.

pred([H|T], [H|LRez]) :-
    number(H),
    !,
    pred(T, LRez).
pred([H|T], [L|LRez]) :-
    dupPrims(H, L),
    pred(T, LRez).

goal :- pred([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5], [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]).



