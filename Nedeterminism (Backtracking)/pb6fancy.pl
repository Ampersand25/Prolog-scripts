/*
6. Sa se genereze toate sirurile de n paranteze ce se inchid corect.
Exemplu: n=4 sunt 2 solutii: (()) si ()()
*/

candidat(H, [H|_]).

candidat(E, [_|T]) :-
    candidat(E, T).

compute('(', V, NewV) :-
    !,
    NewV is V + 1.
compute(')', V, NewV) :- % compute(_, V, NewV) :-
    NewV is V - 1.

invertListRec([], Col, Col) :- !.

invertListRec([H|T], LInverted, Col) :-
    invertListRec(T, LInverted, [H|Col]).

invertList(L, LInverted) :-
    invertListRec(L, LInverted, []).

typeSol([H|[]]) :-
    !,
    write(H),
    nl.

typeSol([H|T]) :-
    write(H),
    write(' '),
    typeSol(T).

conditii(N, Paranteze, Lg, V, E, NewV) :-
    Lg < N,
    candidat(E, Paranteze),
    compute(E, V, NewV),
    NewV >= 0.

backtrAux(N, _, Sol, N, 0, Col) :-
    !,
    invertList(Col, Sol),
    typeSol(Sol).

backtrAux(N, Paranteze, Sol, Lg, V, Col) :-
    conditii(N, Paranteze, Lg, V, E, NewV),
    LgInc is Lg + 1,
    backtrAux(N, Paranteze, Sol, LgInc, NewV, [E|Col]).

backtrGen(N, Paranteze, Sol) :-
    backtrAux(N, Paranteze, Sol, 1, 1, ['(']).

isDivisible(N, K) :-
    Mod is mod(N, K),
    Mod = 0.

backtr(0, []) :- !.
backtr(N, []) :-
    \+ isDivisible(N, 2),
    !.

backtr(N, Sol) :-
    Paranteze = ['(', ')'],
    backtrGen(N, Paranteze, Sol).










