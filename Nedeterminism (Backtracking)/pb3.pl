/*
3. Se da sirul a1,..., an.
Se cere sa se determine toate subsirurile strict crescatoare ale sirului a.
*/

candidat([_|T], E) :-
    candidat(T, E).

candidat([H|_], H).

getPosRec(_, [], -1, _) :- !.
getPosRec(H, [H|_], K, K) :- !.

getPosRec(E, [_|T], K, Rez) :-
    Rez1 is Rez + 1,
    getPosRec(E, T, K, Rez1).

getPos(E, L, K) :-
    getPosRec(E, L, K, 0).

conditii(L, H, E) :-
    candidat(L, E),
    E < H,
    getPos(E, L, K1),
    getPos(H, L, K2),
    K1 < K2.

backtrAux(_, Col, Col).

backtrAux(L, Sol, [H|T]) :-
    conditii(L, H, E),
    backtrAux(L, Sol, [E|[H|T]]).

backtr(L, Sol) :-
    candidat(L, E),
    backtrAux(L, Sol, [E]).
