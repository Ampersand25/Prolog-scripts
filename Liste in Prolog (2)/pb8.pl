invertListRec([], Acc, Acc) :- !.

invertListRec([H|T], Acc, LInverted) :-
    invertListRec(T, [H|Acc], LInverted).

invertList(L, LInverted) :-
    invertListRec(L, [], LInverted).

succesorInvertedRec([], 0, []) :- !.
succesorInvertedRec([], 1, [1]) :- !.
succesorInvertedRec(L, 0, L) :- !.

succesorInvertedRec([H|T], Carry, [MOD|LRez]) :-
    H1 is H + Carry,
    DIV is div(H1, 10),
    MOD is mod(H1, 10),
    succesorInvertedRec(T, DIV, LRez).

succesorInverted([], []) :- !.
succesorInverted([0], [1]) :- !.
succesorInverted([1], [2]) :- !.
succesorInverted([2], [3]) :- !.
succesorInverted([3], [4]) :- !.
succesorInverted([4], [5]) :- !.
succesorInverted([5], [6]) :- !.
succesorInverted([6], [7]) :- !.
succesorInverted([7], [8]) :- !.
succesorInverted([8], [9]) :- !.
succesorInverted([9], [0, 1]) :- !.

succesorInverted(L, LRez) :-
    succesorInvertedRec(L, 1, LRez).

% predicat principal subpunctul a)
succesor(L, LRez) :-
    invertList(L, LInverted),
    succesorInvertedRec(LInverted, 1, LRezInverted),
    invertList(LRezInverted, LRez).

% testare predicat subpunctul a)
goal_a :- succesor([1, 9, 3, 5, 9, 9], [1, 9, 3, 6, 0, 0]).

aux([], []) :- !.

aux([H|T], [H|LRez]) :-
    number(H),
    !,
    aux(T, LRez).
aux([H|T], [L|LRez]) :-
    succesor(H, L),
    aux(T, LRez).

% predicat principal subpunctul b)
pred(L, LRez) :-
    aux(L, LRez).

% testare predicat subpunctul b)
goal_b :- pred([1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6], [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]).
