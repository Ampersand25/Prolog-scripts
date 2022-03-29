/*
9. Dandu-se o valoare N, se cere sa se genereze permutarile de N elemente cu proprietatea ca oricare ar fi 2<=i<=n exista un 1<=j<=i astfel incat
|v(i)-v(j)|=1.
*/

candidat(N, K) :-
    N1 is N - 1,
    N1 >= 1,
    candidat(N1, K).

candidat(N, N).

membership(H, [H|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

appendToList(E, [], [E]) :- !.

appendToList(E, [H|T], [H|LRez]) :-
    appendToList(E, T, LRez).

invertList([], []) :- !.

invertList([H|T], LInverted) :-
    invertList(T, LInverted1),
    appendToList(H, LInverted1, LInverted).

conditiiIntermediare(E, L) :-
    EMinus is E - 1,
    membership(EMinus, L),
    !.

conditiiIntermediare(E, L) :-
    EPlus is E + 1,
    membership(EPlus, L).

conditiiContinuare(N, Num, Col, E, Num1) :-
    candidat(N, E),
    \+ membership(E, Col),
    conditiiIntermediare(E, Col),
    Num1 is Num + 1.

backtrAux(N, Sol, N, Col) :-
    !,
    invertList(Col, Sol).

backtrAux(N, Perm, Num, Col) :-
    conditiiContinuare(N, Num, Col, E, Num1),
    backtrAux(N, Perm, Num1, [E|Col]).

backtr(N, Perm) :-
    candidat(N, Candidat),
    backtrAux(N, Perm, 1, [Candidat]).









