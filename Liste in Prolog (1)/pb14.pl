% a)
countElem([], _, 0) :- !.

countElem([E|T], E, Count) :-
    !,
    countElem(T, E, Count_),
    Count is Count_ + 1.
countElem([_|T], E, Count) :-
    countElem(T, E, Count).

deleteElem([], _, []) :- !.

deleteElem([H|T], H, T) :- !.
deleteElem([H|T], E, [H|LRez]) :-
    deleteElem(T, E, LRez).

equalSets([], []) :- !.

equalSets([H|T], L) :-
    %countElem(L, H, Count),
    %Count == 1, %Count = 1
    %!,
    deleteElem(L, H, L_),
    equalSets(T, L_).

% b)
getN([], _, false) :- !.
getN(_, N, false) :-
    N =< 0,
    !.
getN([H|_], 1, H) :- !.

getN([_|T], N, El) :-
    N_ is N - 1,
    getN(T, N_, El).





