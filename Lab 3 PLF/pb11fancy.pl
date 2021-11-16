/*
11. Sa se genereze toate subsirurile de lungime 2n+1, formate doar din 0, -1 sau 1, astfel incat a1 = 0, ..., a2n+1= 0 si | ai+1 – ai| = 1 sau 2, pentru orice 1 <= i <= 2n.
*/

candidat(N, N).

candidat(N, K) :-
    N1 is N - 1,
    N1 >= -1,
    candidat(N1, K).

backtrAux(N, _, [0|T], Lg, [0|T]) :-
    Lg =:= 2 * N + 1,
    !.

backtrAux(N, Domain, Sol, Lg, [H|T]) :-
    Lg < 2 * N + 1,
    candidat(Domain, C),
    C =\= H, % C \= H,
    LgPlus is Lg + 1,
    backtrAux(N, Domain, Sol, LgPlus, [C|[H|T]]).

backtrRec(N, Domain, Sol) :-
    backtrAux(N, Domain, Sol, 1, [0]).

init(N, Domain) :-
    N >= 0,
    Domain is 1.

backtr(N, Sol) :-
    init(N, Domain),
    write('Subsirurile cu proprietatea din enunt sunt:'),
    nl,
    backtrRec(N, Domain, Sol).








