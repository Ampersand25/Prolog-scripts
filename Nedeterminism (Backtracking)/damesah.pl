/*
Să se dispună N dame pe o tablă de șah NxN, încât să nu se atace reciproc.
*/

candidat(N, E) :-
    N >= 2,
    N1 is N - 1,
    candidat(N1, E).

candidat(N, N).

membership(H, [H|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

typeElement(Val, Val) :-
    !,
    write('*').

typeElement(_, _) :-
    write('-').

printLineRec(N, _, Cont) :-
    Cont =:= N + 1,
    !,
    nl.

printLineRec(N, Val, Cont) :-
    typeElement(Val, Cont),
    ContPlus is Cont + 1,
    printLineRec(N, Val, ContPlus).

printLine(N, Val) :-
    printLineRec(N, Val, 1).

printSolution(_, []) :- !.

printSolution(N, [H|T]) :-
    printLine(N, H),
    printSolution(N, T).

modul(A, A) :-
    A >= 0,
    !.

modul(A, R) :-
    R is -A.

invertListRec([], Col, Col) :- !.

invertListRec([H|T], LInverted, Col) :-
    invertListRec(T, LInverted, [H|Col]).

invertList(L, LInverted) :-
    invertListRec(L, LInverted, []).

conditiiRec(_, _, [], _) :- !.

conditiiRec(E, Len, [H|T], Line) :-
    Diff1 is E - H,
    Diff2 is Len - Line,
    modul(Diff1, DiffAbs1),
    modul(Diff2, DiffAbs2),
    DiffAbs1 =\= DiffAbs2,
    NextLine is Line + 1,
    conditiiRec(E, Len, T, NextLine).

conditii(E, Len, Col) :-
    invertList(Col, ColInverted),
    conditiiRec(E, Len, ColInverted, 1).

conditiiContinuare(N, Len, Col, E, LenPlus) :-
    candidat(N, E),
    \+ membership(E, Col),
    LenPlus is Len + 1,
    LenPlus =< N,
    conditii(E, LenPlus, Col).

backtrAux(N, Col, N, Col) :-
    !,
    printSolution(N, Col).

backtrAux(N, Sol, Len, Col) :-
    conditiiContinuare(N, Len, Col, E, LenPlus),
    backtrAux(N, Sol, LenPlus, [E|Col]).

backtr(N, Sol) :-
    write('Problema damelor:'),
    nl,
    candidat(N, E),
    backtrAux(N, Sol, 1, [E]).









