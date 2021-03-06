% Subpunctul a)
len([], 0) :- !.

len([_|T], N) :-
    len(T, N1),
    N is N1 + 1.

cmpLists(L1, L2) :-
    len(L1, N1),
    len(L2, N2),
    N1 < N2.

isEven(N) :-
    MOD is mod(N, 2),
    MOD == 0.

isOdd(N) :-
    \+ isEven(N).

pushBack([], E, [E]) :- !.

pushBack([H|T], E, [H|LRez]) :-
    pushBack(T, E, LRez).

invertListAlt([], []) :- !.

invertListAlt([H|T], LRez) :-
    invertListAlt(T, LRez_),
    pushBack(LRez_, H, LRez).

invertListRec([], Col, Col) :- !.

invertListRec([H|T], Col, LInverted) :-
    invertListRec(T, [H|Col], LInverted).

invertList(L, LInverted) :-
    invertListRec(L, [], LInverted).

smaxRec([], Curr, Max, Curr) :-
    cmpLists(Max, Curr),
    !.
smaxRec([], _, Max, Max) :- !.

smaxRec([H|T], Curr, Max, SMax) :-
    isOdd(H), % \+ isEven(H)
    %!,
    cmpLists(Max, Curr), % \+ cmpLists(Curr, Max)
    !,
    smaxRec(T, [], Curr, SMax).
smaxRec([H|T], _, Max, SMax) :-
    isOdd(H), % \+ isEven(H)
    !,
    %cmpLists(Curr, Max), % \+ cmpLists(Max, Curr)
    %!,
    smaxRec(T, [], Max, SMax).
smaxRec([H|T], Curr, Max, SMax) :-
    %isEven(H), % \+ isOdd(H)
    %!,
    smaxRec(T, [H|Curr], Max, SMax).

smax(L, SMax) :-
    smaxRec(L, [], [], SMaxInverted),
    invertList(SMaxInverted, SMax).

% Subpunctul b)
pred([], []) :- !.

pred([H|T], [H|LRez]) :-
    number(H), % \+ is_list(H)
    !,
    pred(T, LRez).
pred([H|T], [L|LRez]) :-
    smax(H, L),
    pred(T, LRez).

goal :- pred([1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3], [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]).






