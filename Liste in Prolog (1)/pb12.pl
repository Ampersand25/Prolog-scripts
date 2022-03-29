% a)
switchEl([], _, _, []) :- !.
switchEl([E|[]], E, F, [F]) :- !.
switchEl([H], _, _, [H]) :- !.

switchEl([E|T], E, F, [F|LRez]) :-
    !,
    switchEl(T, E, F, LRez).
switchEl([H|T], E, F, [H|LRez]) :-
    switchEl(T, E, F, LRez).

% b)
inInterval(X, A, B) :-
    X >= A,
    X =< B.

prel([H|_], Cont, M, N, L, [H|L]) :-
    inInterval(Cont, M, N),
    !.
prel(_, _, _, _, L, L).

% Varianta cu refactorizare (evitarea codului duplicat)
subListRec([], _, _, _, []) :- !.
subListRec([H|_], N, _, N, [H]) :- !.

subListRec([H|T], Cont, M, N, LRez) :-
    Cont_ is Cont + 1,
    subListRec(T, Cont_, M, N, L),
    prel([H|T], Cont, M, N, L, LRez).

% Varianta fara refactorizare
/*
subListRec([H|T], Cont, M, N, [H|LRez]) :-
    inInterval(Cont, M, N),
    !,
    Cont_ is Cont + 1,
    subListRec(T, Cont_, M, N, LRez).
subListRec([_|T], Cont, M, N, LRez) :-
    Cont_ is Cont + 1,
    subListRec(T, Cont_, M, N, LRez).
*/

subList(L, M, N, LRez) :-
    M > N,
    !,
    subListRec(L, 1, N, M, LRez).
subList(L, M, N, LRez) :-
    subListRec(L, 1, M, N, LRez).
