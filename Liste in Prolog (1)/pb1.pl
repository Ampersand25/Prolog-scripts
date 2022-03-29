% a)
membership(H, [H|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

diff([], _, []) :- !.
diff(L, [], L) :- !.

diff([H|T], L, LRez) :-
    membership(H, L),
    !,
    diff(T, L, LRez).
diff([H|T], L, [H|LRez]) :-
    diff(T, L, LRez).

% b)
isEven(N) :-
    MOD is mod(N, 2),
    MOD == 0.

addList([], []) :- !.
addList([H], [H, 1]) :-
    isEven(H),
    !.
addList([H], [H]) :- !.

addList([H|T], [H|LRez]) :-
    \+ isEven(H),
    !,
    addList(T, LRez).
addList([H|T], [H|[1|LRez]]) :-
    addList(T, LRez).
