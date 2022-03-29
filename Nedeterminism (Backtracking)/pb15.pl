/*
15. Se da un numar n pozitiv.
Se cere sa se determine toate descompunerile lui n ca suma de numere
naturale consecutive.
*/

candidat(N, N) :-
    N > 0.

candidat(N, K) :-
    N >= 1,
    NMinus is N - 1,
    candidat(NMinus, K).

printSolutionRec([H|[]]) :-
    !,
    write(H).

printSolutionRec([H|T]) :-
    write(H),
    write(' + '),
    printSolutionRec(T).

printSolution(N, L) :-
    printSolutionRec(L),
    write(' = '),
    write(N),
    nl.

conditii(N, Sum, H, E, NewSum) :-
    E is H - 1,
    E > 0,
    NewSum is Sum + E,
    NewSum =< N.

backtrAux(N, Col, N, Col) :-
    !,
    printSolution(N, Col).

backtrAux(N, Sol, Sum, [H|T]) :-
    conditii(N, Sum, H, E, NewSum),
    backtrAux(N, Sol, NewSum, [E|[H|T]]).

backtr(N, Sol) :-
    write('Descompunerile lui '),
    write(N),
    write(' in suma de numere consecutive sunt:'),
    nl,
    NMinus is N - 1,
    candidat(NMinus, E),
    backtrAux(N, Sol, E, [E]).
