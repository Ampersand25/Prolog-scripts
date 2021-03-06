listNumberRec([], Col, Col) :- !.

listNumberRec([H|T], Col, N) :-
    Col1 is Col * 10 + H,
    listNumberRec(T, Col1, N).

listNumber(L, N) :-
    listNumberRec(L, 0, N).

numberListRec(0, Col, Col) :- !.

numberListRec(N, Col, L) :-
    Div is div(N, 10),
    Mod is mod(N, 10),
    numberListRec(Div, [Mod|Col], L).

numberList(0, [0]) :- !.

numberList(N, L) :-
    numberListRec(N, [], L).

% predicatul de la subpunctul a)
prodListDigit(L, Digit, LRez) :-
    listNumber(L, LNumber),
    LRezNumber is LNumber * Digit,
    numberList(LRezNumber, LRez).

% testam predicatul de la subpunctul a)
goal_a :- prodListDigit([1, 9, 3, 5, 9, 9], 2, [3, 8, 7, 1, 9, 8]).

aux([], _, []) :- !.
aux([H], _, [H]) :- \+ is_list(H), !.
aux([H], 1, [H]) :- is_list(H), !.

aux([H|T], Idx, [H|LRez]) :-
    number(H),
    !,
    aux(T, Idx, LRez).
aux([H|T], Idx, [L|LRez]) :-
    %is_list(H),
    prodListDigit(H, Idx, L),
    IdxPlus is Idx + 1,
    aux(T, IdxPlus, LRez).

% predicatul de la subpunctul b)
pred(L, LRez) :-
    aux(L, 1, LRez).

% testam predicatul de la subpunctul b)
goal_b :- pred([1, [2, 3], [4, 1, 4], 3, 6, [7, 5, 1, 3, 9], 5, [1, 1, 1], 7], [1, [2, 3], [8, 2, 8], 3, 6, [2, 2, 5, 4, 1, 7], 5, [4, 4, 4], 7]).
