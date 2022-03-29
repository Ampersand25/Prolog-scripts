invertListRec([], Col, Col) :- !.

invertListRec([H|T], Col, LInverted) :-
    invertListRec(T, [H|Col], LInverted).

invertList(L, LInverted) :-
    invertListRec(L, [], LInverted).

pushBack([], E, [E]) :- !.
pushBack([H|[]], E, [H, E]) :- !. % pushBack([H], E, [H|E]) :- !.

pushBack([H|T], E, [H|LRez]) :-
    pushBack(T, E, LRez).

invertListAlt([], []) :- !.
invertListAlt([H], [H]) :- !.
invertListAlt([H1|[H2|[]]], [H2, H1]) :- !. % invertListAlt([H1|[H2]], [H2, H1]) :- !.

invertListAlt([H|T], LRez) :-
    invertListAlt(T, L),
    pushBack(L, H, LRez).

prodListDigitRec([], _, 0, []) :- !.
prodListDigitRec([], _, Carry, [Carry]) :- !.
prodListDigitRec(L, 1, _, L) :- !.

prodListDigitRec([H|T], Digit, Carry, [Mod|TLRez]) :-
    Mul is H * Digit + Carry,
    Div is div(Mul, 10),
    Mod is mod(Mul, 10),
    prodListDigitRec(T, Digit, Div, TLRez).

% predicat principal subpunctul a)
prodListDigit(L, Digit, LRez) :-
    invertList(L, LInverted),
    prodListDigitRec(LInverted, Digit, 0, LRezInverted),
    invertList(LRezInverted, LRez).

% testare predicat subpunctul a)
goal_a :- prodListDigit([1, 9, 3, 5, 9, 9], 2, [3, 8, 7, 1, 9, 8]).

aux([], _, []) :- !.

aux([H|T], Index, [L|LRez]) :-
    is_list(H),
    !,
    prodListDigit(H, Index, L),
    IndexPlus is Index + 1,
    aux(T, IndexPlus, LRez).
aux([H|T], Index, [H|LRez]) :-
    aux(T, Index, LRez).

% predicat principal subpunctul b)
prod(L, LRez) :-
    aux(L, 1, LRez).

% testare predicat subpunct b)
goal_b :- prod([1, [2, 3], [4, 1, 4], 3, 6, [7, 5, 1, 3, 9], 5, [1, 1, 1], 7], [1, [2, 3], [8, 2, 8], 3, 6, [2, 2, 5, 4, 1, 7], 5, [4, 4, 4], 7]).











