/*
6. Sa se genereze toate sirurile de n paranteze ce se inchid corect.
Exemplu: n=4 sunt 2 solutii: (()) si ()()
*/

candidat(N, N).

candidat(N, K) :-
    N > 0,
    NDec is N - 1,
    candidat(NDec, K).

compute(0, V, NewV) :-
    !,
    NewV is V + 1.
compute(1, V, NewV) :- % compute(_, V, NewV) :-
    NewV is V - 1.

invertList([], Col, Col) :- !.

invertList([H|T], LInverted, Col) :-
    invertList(T, LInverted, [H|Col]).

getParanteza(0, '(') :- !.

getParanteza(1, ')'). % getParanteza(_, ')').

typeParanteza(H) :-
    getParanteza(H, Paranteza),
    write(Paranteza).

typeSol([]) :-
    !,
    nl.

typeSol([H|T]) :-
    typeParanteza(H),
    typeSol(T).

conditii(N, Lg, V, E, NewV) :-
    Lg < N,
    candidat(1, E),
    compute(E, V, NewV),
    NewV >= 0.

backtrAux(N, Sol, N, 0, Col) :-
    !,
    invertList(Col, Sol, []),
    typeSol(Sol).

backtrAux(N, Sol, Lg, V, Col) :-
    %Lg < N,
    %candidat(1, E),
    %compute(E, V, NewV),
    %NewV >= 0,
    conditii(N, Lg, V, E, NewV),
    LgInc is Lg + 1,
    backtrAux(N, Sol, LgInc, NewV, [E|Col]).

backtr(N, []) :-
    N mod 2 =:= 1, % mod(N, 2) == 1,
    !.
backtr(0, []) :- !.

backtr(N, Sol) :-
    backtrAux(N, Sol, 1, 1, [0]).



