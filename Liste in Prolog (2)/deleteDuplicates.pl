membership(E, [E|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

deleteDups([], []) :- !.

deleteDups([H|T], [H|LRez]) :-
    \+ membership(H, T),
    !,
    deleteDups(T, LRez).
deleteDups([_|T], LRez) :-
    deleteDups(T, LRez).

deleteDupsSorted([], []) :- !.
deleteDupsSorted([H], [H]) :- !.
deleteDupsSorted([H|[H]], [H]) :- !.
deleteDupsSorted([H1|[H2|[]]], [H1, H2]) :- !.

deleteDupsSorted([H|[H|T]], LRez) :-
    !,
    deleteDupsSorted([H|T], LRez).
deleteDupsSorted([H1|[H2|T]], [H1|LRez]) :-
    deleteDupsSorted([H2|T], LRez).

deleteDupsSortedAlt([], _, []) :- !.
deleteDupsSortedAlt([H], Last, []) :- % deleteDupsSortedAlt([H], H, []) :- !.
    H == Last, % H = Last
    !.
deleteDupsSortedAlt([H], _, [H]) :- !.

/*
deleteDupsSortedAlt([H|T], Last, LRez) :-
    H == Last, % H = Last
    !,
    deleteDupsSortedAlt(T, H, LRez).
*/
deleteDupsSortedAlt([H|T], H, LRez) :-
    !,
    deleteDupsSortedAlt(T, H, LRez).
deleteDupsSortedAlt([H|T], _, [H|LRez]) :-
    deleteDupsSortedAlt(T, H, LRez).

delete([], []) :- !.

delete([H|T], [H|LRez]) :-
    deleteDupsSortedAlt(T, H, LRez).





