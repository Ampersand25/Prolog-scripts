% a)
%intersect([], [], []) :- !.
intersect([], _, []) :- !.
intersect(_, [], []) :- !.

intersect([H|T], L, LRez) :-
    \+ member(H, L),
    !,
    intersect(T, L, LRez).
intersect([H|T], L, [H|LRez]) :-
    intersect(T, L, LRez).

% b)
computeList(X, X, [X]) :- !.
computeList(X, Y, []) :-
    X > Y,
    !.

computeList(M, N, [M|LRez]) :-
    M_ is M + 1,
    computeList(M_, N, LRez).

computeList2Rec(X, X, Col, [X|Col]) :- !.

computeList2Rec(M, N, Col, LRez) :-
    N_ is N - 1,
    computeList2Rec(M, N_, [N|Col], LRez).

computeList2(X, Y, []) :-
    \+(X =< Y),
    !.

computeList2(M, N, LRez) :-
    computeList2Rec(M, N, [], LRez).

pushBack([], E, [E]) :- !.

pushBack([H|T], E, [H|LRez]) :-
    pushBack(T, E, LRez).

computeList3(X, X, [X]) :- !.
computeList3(X, Y, []) :-
    X > Y,
    !.

computeList3(M, N, LRez) :-
    N_ is N - 1,
    computeList3(M, N_, LRez_),
    pushBack(LRez_, N, LRez).



