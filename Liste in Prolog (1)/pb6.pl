% a)
deleteElement([], _, []) :- !.

deleteElement([H|T], E, [H|LRez]) :-
    H =\= E,
    !,
    deleteElement(T, E, LRez).
deleteElement([_|T], E, LRez) :-
    deleteElement(T, E, LRez).

deleteDuplicates([], []) :- !.
deleteDuplicates([H|[]], [H]) :- !.

deleteDuplicates([H|T], LRez) :-
    member(H, T),
    !,
    deleteElement(T, H, T_),
    deleteDuplicates(T_, LRez).
deleteDuplicates([H|T], [H|LRez]) :-
    deleteDuplicates(T, LRez).

go :- deleteDuplicates([1, 2, 1, 4, 1, 3 , 4], [2, 3]).

% b)
maximRec([], MAX, MAX) :- !.

maximRec([H|T], MAX, Rez) :-
    H =< MAX,
    !,
    maximRec(T, MAX, Rez).
maximRec([H|T], _, Rez) :-
    maximRec(T, H, Rez).

maxim([], -1) :- !.

maxim([H|T], MAX) :-
    maximRec(T, H, MAX).

deleteMaxRec([], _, []) :- !.

deleteMaxRec([E|T], E, LRez) :-
    !,
    deleteMaxRec(T, E, LRez).
deleteMaxRec([H|T], E, [H|LRez]) :-
    deleteMaxRec(T, E, LRez).

deleteMax(L, LRez) :-
    maxim(L, MAX),
    deleteMaxRec(L, MAX, LRez).






