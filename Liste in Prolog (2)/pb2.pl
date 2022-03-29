part(_, [], [], []) :- !.

part(Pivot, [H|T], Less, Greater) :-
    H =< Pivot,
    !,
    part(Pivot, T, Less_, Greater),
    Less = [H|Less_].
part(Pivot, [H|T], Less, Greater) :-
    part(Pivot, T, Less, Greater_),
    Greater = [H|Greater_].

conc([], [], []) :- !.
conc([], [H|[]], [H]) :- !.
conc([H|[]], [], [H]) :- !.
conc([H1|[]], [H2|[]], [H1, H2]) :- !.
conc([], L, L) :- !.
conc(L, [], L) :- !.

conc([H|T], L, [H|LRez]) :-
    conc(T, L, LRez).

qsort([], []) :- !.

qsort([H|T], LSorted) :-
    Pivot = H,
    part(Pivot, T, Less, Greater),
    qsort(Less, LessSorted),
    qsort(Greater, GreaterSorted),
    conc(LessSorted, [Pivot|GreaterSorted], LSorted).

goal_a :- qsort([4, 2, 6, 2, 3, 4], [2, 2, 3, 4, 4, 6]).

sortSublists([], []) :- !.
sortSublists([H|[]], [H]) :-
    number(H), % \+ is_list(H)
    !.
sortSublists([H|[]], HSorted) :-
    qsort(H, HSorted).

sortSublists([H|T], LRez) :-
    is_list(H), % \+ number(H)
    !,
    qsort(H, HSorted),
    sortSublists(T, LRez_),
    LRez = [HSorted|LRez_].
sortSublists([H|T], LRez) :-
    sortSublists(T, LRez_),
    LRez = [H|LRez_].

/*
sortSublists([H|T], [HSorted|LRez]) :-
    is_list(H), % \+ number(H)
    !,
    qsort(H, HSorted),
    sortSublists(T, LRez).
sortSublists([H|T], [H|LRez]) :-
    sortSublists(T, LRez).
*/

goal_b :- sortSublists([1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [1, 2, [1, 4, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1, 1, 1], 7]).







