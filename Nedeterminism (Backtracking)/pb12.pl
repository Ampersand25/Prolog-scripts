/*
12. Se da sirul a1,..., an format din numere intregi distincte.
Se cere sa se afiseze toate submultimile cu aspect de "munte"(o secvență se spune ca are aspect de "munte" daca elementele cresc pana la un moment dat, apoi descresc.
De ex. 10 16 27 18 14 7).
*/

candidat(Candidat, [Candidat|_]).

candidat(Candidat, [_|T]) :-
    candidat(Candidat, T).

getPositionInList(Elem, [Elem|_], 0) :- !.

getPositionInList(Elem, [_|T], Position) :-
    getPositionInList(Elem, T, Position1),
    Position is Position1 + 1.

conditiiContinuare(A, [H|_], C, PosC) :-
    candidat(C, A),
    getPositionInList(C, A, PosC),
    PosC < H.

munteRec([], 1) :- !.
munteRec([_|[]], 1) :- !.

munteRec([H1, H2|T], 0) :-
    H1 < H2,
    !,
    munteRec([H2|T], 0).

munteRec([H1, H2|T], _) :-
    H1 > H2,
    munteRec([H2|T], 1).

munteWrapper([H1, H2, H3|T]) :-
    H1 < H2,
    munteRec([H1|[H2|[H3|T]]], 0).

conditiiFinale(List) :-
    munteWrapper(List).

backtrAux(_, Col, _, Col) :-
    conditiiFinale(Col).

backtrAux(A, Sol, Positions, Col) :-
    conditiiContinuare(A, Positions, C, PosC),
    backtrAux(A, Sol, [PosC|Positions], [C|Col]).

backtr(A, Sol) :-
    candidat(C, A),
    getPositionInList(C, A, PosC),
    backtrAux(A, Sol, [PosC], [C]).
