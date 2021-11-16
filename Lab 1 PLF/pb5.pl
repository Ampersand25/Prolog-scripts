% a)
deleteAtom([], _, []) :- !.
deleteAtom([E], E, []) :- !.
deleteAtom([H], _, [H]) :- !.

deleteAtom([E|T], E, LRez) :-
    !,
    deleteAtom(T, E, LRez).
deleteAtom([H|T], E, [H|LRez]) :-
    deleteAtom(T, E, LRez).

% b)
countElem([], _, 0) :- !.
countElem([E|[]], E, 1) :- !.
countElem([_|[]], _, 0) :- !.

countElem([E|T], E, Count) :-
    !,
    countElem(T, E, Count_),
    Count is Count_ + 1.
countElem([_|T], E, Count) :-
    countElem(T, E, Count).

numar([], []) :- !.

numar([H|T], [[H, Count]|LRez]) :-
    countElem([H|T], H, Count),
    deleteAtom(T, H, T_),
    numar(T_, LRez).

go :- numar([1, 2, 1, 2, 1, 3, 1], [[1, 4], [2, 2], [3, 1]]).
