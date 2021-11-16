/*
2. Fiind dat un numar n pozitiv, se cere sa se determine toate descompunerile sale ca suma de numere prime distincte.
*/

candidat(N, N).

candidat(N, K) :-
    N > 0,
    N1 is N - 1,
    candidat(N1, K).

isDivisible(N, K) :-
    MOD is mod(N, K),
    MOD == 0. % MOD =:= 0.
              % MOD = 0.

isPrimeRec(N, N) :- !.

isPrimeRec(N, K) :-
    \+ isDivisible(N, K),
    K1 is K + 1,
    isPrimeRec(N, K1).

isPrime(2) :- !.

isPrime(N) :-
    N > 2,         % N >= 2,
    N mod 2 =\= 0, % mod(N, 2) =:= 1,
    isPrimeRec(N, 2).

conditii(N, H, Sum, E, NewSum) :-
    H1 is H - 1,
    candidat(H1, E),
    isPrime(E),
    NewSum is Sum + E,
    NewSum =< N.

typeSolutionRec([H|[]]) :-
    write(H),
    !.

typeSolutionRec([H|T]) :-
    write(H),
    write(' + '),
    typeSolutionRec(T).

typeSolution(L, N) :-
    typeSolutionRec(L),
    write(' = '),
    write(N),
    nl.

backtrAux(N, [H1|[H2|T]], N, [H1|[H2|T]]) :-
    Sol = [H1, H2|T],
    typeSolution(Sol, N).

backtrAux(N, Sol, Sum, [H|T]) :-
    conditii(N, H, Sum, E, NewSum),
    backtrAux(N, Sol, NewSum, [E|[H|T]]).

backtr(N, Sol) :-
    candidat(N, Candidat),
    isPrime(Candidat),
    backtrAux(N, Sol, Candidat, [Candidat]).
















