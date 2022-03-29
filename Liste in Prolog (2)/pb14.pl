pushBack([], E, [E]) :- !.

pushBack([H|T], E, [H|LRez]) :-
    pushBack(T, E, LRez).

invertList([], []) :- !.
invertList([H], [H]) :- !.
invertList([H1|[H2]], [H2, H1]) :- !.

invertList([H|T], LRez) :-
    invertList(T, L),
    pushBack(L, H, LRez).

predecesorInverted([], _, []) :- !.
%predecesorInverted([1], 0, [1]) :- !.
predecesorInverted([1], 1, []) :- !.
predecesorInverted([H], 0, [H]) :- !.
predecesorInverted([H], 1, [H1]) :-
    H1 is H - 1,
    !.

predecesorInverted([H|T], Borrow, [9|LRez]) :-
    Diff is H - Borrow,
    Diff == -1,
    !,
    predecesorInverted(T, 1, LRez).
predecesorInverted([H|T], Borrow, [Diff|LRez]) :-
    Diff is H - Borrow,
    predecesorInverted(T, 0, LRez).

predecesor([], []) :- !.
predecesor([0], [-1]) :- !.
predecesor([1], [0]) :- !.
predecesor([2], [1]) :- !.
predecesor([3], [2]) :- !.
predecesor([4], [3]) :- !.
predecesor([5], [4]) :- !.
predecesor([6], [5]) :- !.
predecesor([7], [6]) :- !.
predecesor([8], [7]) :- !.
predecesor([9], [8]) :- !.
predecesor([1, 0], [9]) :- !.

predecesor(L, LRez) :-
    invertList(L, LInverted),
    predecesorInverted(LInverted, 1, LRezInverted),
    invertList(LRezInverted, LRez).

goal_a :- predecesor([1, 9, 3, 6, 0, 0], [1, 9, 3, 5, 9, 9]).

pred([], []) :- !.

pred([H|T], [H|LRez]) :-
    number(H),
    !,
    pred(T, LRez).
pred([H|T], [L|LRez]) :-
    predecesor(H, L),
    pred(T, LRez).

goal_b :- pred([1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6], [1, [2, 2], 4, 5, [6, 7, 8], 10, 11, [1, 1, 9], 6]).













