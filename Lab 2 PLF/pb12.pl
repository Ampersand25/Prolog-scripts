replace([], _, _, []) :- !.

replace([E|T], E, F, [F|LRez]) :-
    !,
    replace(T, E, F, LRez).
replace([H|T], E, F, [H|LRez]) :-
    replace(T, E, F, LRez).

maximList([], NMax, NMax) :- !.

maximList([H|T], NMax, Rez) :-
    is_list(H),
    !,
    maximList(T, NMax, Rez).
maximList([H|T], NMax, Rez) :-
    H >= NMax,
    !,
    maximList(T, H, Rez).
maximList([_|T], NMax, Rez) :-
    maximList(T, NMax, Rez).

maximWrapper([H|T], Max) :-
    maximList(T, H, Max).

replaceList([], _, []) :- !.

replaceList([H|T], MaxList, [H|LRez]) :-
    number(H),
    !,
    replaceList(T, MaxList, LRez).
replaceList([H|T], MaxList, [L|LRez]) :-
    maximWrapper(H, MaxSublist),
    replace(H, MaxList, MaxSublist, L),
    replaceList(T, MaxList, LRez).

replaceListWrapper(L, LRez) :-
    maximWrapper(L, Max),
    replaceList(L, Max, LRez).

goal :- replaceListWrapper([1, [2, 5, 7], 4, 5, [1, 4], 3, [1, 3, 5, 8, 5, 4], 5, [5, 9, 1], 2], [1, [2, 7, 7], 4, 5, [1, 4], 3, [1, 3, 8, 8, 8, 4], 5, [9, 9, 1], 2]).
