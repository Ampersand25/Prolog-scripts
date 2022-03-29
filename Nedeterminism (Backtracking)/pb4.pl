/*
4. Se dau doua numere naturale n si m.
Se cere sa se afiseze in toate modurile posibile toate numerele de la 1 la n, astfel incat intre orice doua numere afisate pe pozitii consecutive, diferenta in modul sa fie >=m.
*/

candidat(N, K) :-
    N1 is N - 1,
    N1 >= 1,
    candidat(N1, K).

candidat(N, N) :-
    N > 0.

modul(A, A) :-
    A >= 0,
    !.

modul(A, Modul) :-
    Modul is -A. % Modul is A * (-1).

diffAbs(A, B, DiffAbs) :-
    Diff is A - B, % Diff is B - A,
    modul(Diff, DiffAbs).

membership(H, [H|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

conditiiContinuare(N, M, Len, [H|T], E, LenPlusPlus) :-
    Len < N,
    candidat(N, E),
    Col = [H|T],
    \+ membership(E, Col),
    diffAbs(E, H, D),
    D >= M,
    LenPlusPlus is Len + 1.

backtrAux(N, _, Col, N, Col) :-
    !.

backtrAux(N, M, Sol, Len, Col) :-
    conditiiContinuare(N, M, Len, Col, E, LenPlusPlus),
    backtrAux(N, M, Sol, LenPlusPlus, [E|Col]).

backtr(N, M, Sol) :-
    N > 1,  % N >= 2,
    M \= 0, % M =\= 0,
    M < N,
    candidat(N, E),
    backtrAux(N, M, Sol, 1, [E]).








