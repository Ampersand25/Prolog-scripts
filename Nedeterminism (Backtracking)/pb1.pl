/*
1. Se dau N puncte in plan (prin coordonatele lor).
Se cere sa se determine toate submultimile de puncte coliniare.
*/

candidat([H|_], H).

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

getPosition(H, [H|_], 0) :- !.

getPosition(E, [_|T], Cont) :-
    getPosition(E, T, Cont1),
    Cont is Cont1 + 1.

computeFirst([X1, Y1], [X2, Y2], [X3, Y3], Sum) :-
    P1 is 1 * X2 * Y3,
    P2 is 1 * X3 * Y1,
    P3 is 1 * X1 * Y2,
    Sum is P1 + P2 + P3.

computeSecond([X1, Y1], [X2, Y2], [X3, Y3], Sum) :-
    P1 is Y1 * X2 * 1,
    P2 is Y2 * X3 * 1,
    P3 is Y3 * X1 * 1,
    Sum is P1 + P2 + P3.

coliniaritate(PA, PB, PC) :-
    computeFirst(PA, PB, PC, Sum1),
    computeSecond(PA, PB, PC, Sum2),
    Sum1 - Sum2 =:= 0.

conditii(Points, [PA|[PB|_]], [PosA|_], PC, PosC) :-
    candidat(Points, PC),
    getPosition(PC, Points, PosC),
    PosC < PosA,
    coliniaritate(PA, PB, PC).

backtrAux(_, Col, _, Col).

backtrAux(Points, Sol, PointsIDX, Col) :-
    conditii(Points, Col, PointsIDX, PC, PosC),
    backtrAux(Points, Sol, [PosC|PointsIDX], [PC|Col]).

init(Points, PA, PosA, PB, PosB) :-
    candidat(Points, PA),
    getPosition(PA, Points, PosA),
    candidat(Points, PB),
    getPosition(PB, Points, PosB),
    PosA < PosB.

backtr(Points, Sol) :-
    init(Points, PA, PosA, PB, PosB),
    backtrAux(Points, Sol, [PosA, PosB|[]], [PA|[PB|[]]]).









