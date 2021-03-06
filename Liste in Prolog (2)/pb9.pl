deleteRec([], _, []) :- !.

deleteRec([H1|[H2|T]], false, LRez) :-
    H1 =:= H2 - 1,
    !,
    deleteRec([H2|T], H1, LRez).
deleteRec([H1|[H2|T]], false, [H1|LRez]) :-
    !,
    deleteRec([H2|T], H1, LRez).

deleteRec([H1|[H2|T]], Last, LRez) :-
    H1 =:= H2 - 1,
    !,
    deleteRec([H2|T], H1, LRez);
    H1 =:= Last + 1,
    !,
    deleteRec([H2|T], H1, LRez).

deleteRec([H|T], Last, LRez) :-
    H =:= Last + 1,
    !,
    deleteRec(T, H, LRez).
deleteRec([H|T], _, [H|LRez]) :-
    deleteRec(T, H, LRez).

deleteWrapper([H], [H]) :- !.
deleteWrapper([H1|[H2|[]]], []) :-
    H2 =:= H1 + 1,
    !.
deleteWrapper([H1|[H2|[]]], [H1, H2]) :- !.

deleteWrapper(L, LRez) :-
    deleteRec(L, false, LRez).

goal_a :- deleteWrapper([1, 2, 4, 6, 7, 8, 10], [4, 10]).

foobar([], []) :- !.

foobar([H|T], [H|LRez]) :-
    number(H),
    !,
    foobar(T, LRez).
foobar([H|T], [L|LRez]) :-
    deleteWrapper(H, L),
    foobar(T, LRez).

goal_b_1 :- foobar([1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7], [1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7]).

fooRec([], Col, Col) :- !.

fooRec([H|T], Col, LRez) :-
    is_list(H),
    !,
    deleteWrapper(H, L),
    fooRec(T, [L|Col], LRez).
fooRec([H|T], Col, LRez) :-
    fooRec(T, [H|Col], LRez).

invertRec([], Col, Col) :- !.

invertRec([H|T], Col, LRez) :-
    invertRec(T, [H|Col], LRez).

invert(L, LRez) :-
    invertRec(L, [], LRez).

foo(L, LRez) :-
    fooRec(L, [], LRezInverted),
    invert(LRezInverted, LRez).

goal_b_2 :- foo([1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7], [1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7]).









