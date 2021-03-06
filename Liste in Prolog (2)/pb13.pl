divsRec(N, N, [N]) :- !.

divsRec(N, Div, LRez) :-
    Mod is mod(N, Div),
    Mod == 0,
    !,
    NextDiv is Div + 1,
    divsRec(N, NextDiv, L),
    LRez = [Div|L].
divsRec(N, Div, LRez) :-
    NextDiv is Div + 1,
    divsRec(N, NextDiv, LRez).

divsWrapper(N, L) :-
    divsRec(N, 1, L).

len([], 0) :- !.

len([_|T], N) :-
    len(T, N1),
    N is N1 + 1.

divsProperRec(N, N, []) :- !.
divsProperRec(0, _, []) :- !.
divsProperRec(1, _, []) :- !.

divsProperRec(N, Div, [Div|LRez]) :-
    Mod is mod(N, Div),
    Mod = 0,
    !,
    DivPlusPlus is Div + 1,
    divsProperRec(N, DivPlusPlus, LRez).
divsProperRec(N, Div, LRez) :-
    DivPlusPlus is Div + 1,
    divsProperRec(N, DivPlusPlus, LRez).

divsProper(L, LRez) :-
    divsProperRec(L, 2, LRez).

conc([], [], []) :- !.
conc([], L, L) :- !.
conc(L, [], L) :- !.

conc([H|T], L, [H|LRez]) :-
    conc(T, L, LRez).

changeList([], []) :- !.

changeList([H|T], LRez) :-
    divsProper(H, L),
    len(L, Len),
    Len =\= 0,
    !,
    divsProper(H, L),
    changeList(T, L_),
    conc([H|L], L_, LRez).
changeList([H|T], [H|LRez]) :-
    changeList(T, LRez).

pred([], []) :- !.

pred([H|T], [H|LRez]) :-
    number(H),
    !,
    pred(T, LRez).
pred([H|T], [L|LRez]) :-
    changeList(H, L),
    pred(T, LRez).

goal :- pred([1, [2, 5, 7], 4, 5, [1, 4], 3, 2, [6, 2, 1], 4, [7, 2, 8, 1], 2], [1, [2, 5, 7], 4, 5, [1, 4, 2], 3, 2, [6, 2, 3, 2, 1], 4, [7, 2, 8, 2, 4, 1], 2]).



