maximumRec([], NMax, NMax) :- !.

maximumRec([H|T], NMax, Rez) :-
    H > NMax,
    !,
    maximumRec(T, H, Rez).
maximumRec([_|T], NMax, Rez) :-
    maximumRec(T, NMax, Rez).

maximum([], -1) :- !.
maximum([H|[]], H) :- !.
maximum([H1|[H2|[]]], H2) :-
    H1 =< H2,
    !.
maximum([H1|[_|[]]], H1) :- !.

maximum([H1|T], NMax) :-
    maximumRec(T, H1, NMax).

maxIndexRec([], _, _, []) :- !.

maxIndexRec([NMax|T], Idx, NMax, [Idx|LRez]) :-
    !,
    NextIdx is Idx + 1,
    maxIndexRec(T, NextIdx, NMax, LRez).
maxIndexRec([_|T], Idx, NMax, LRez) :-
    NextIdx is Idx + 1,
    maxIndexRec(T, NextIdx, NMax, LRez).

poz(L, LIndex) :-
    maximum(L, NMax),
    maxIndexRec(L, 1, NMax, LIndex).

goal_a :- poz([10, 14, 12, 13, 14], [2, 5]).

pred([], []) :- !.
pred([H], [H]) :-
    number(H),
    !.
pred([H], L) :-
    !,
    poz(H, L).

pred([H|T], [L|LRez]) :-
    is_list(H),
    !,
    poz(H, L),
    pred(T, LRez).
pred([H|T], [H|LRez]) :-
    pred(T, LRez).

goal_b :- pred([1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]).


