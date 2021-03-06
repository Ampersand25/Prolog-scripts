/*
1. Se dau N puncte in plan (prin coordonatele lor).
Se cere sa se determine toate submultimile de puncte coliniare.
*/

candidat(N, N).

candidat(N, K) :-
    N1 is N - 1,
    N1 >= 1,
    candidat(N1, K).

lenList([], 0) :- !.

lenList([_|T], Len) :-
    lenList(T, Len1),
    Len is Len1 + 1.

getElem(1, [H|_], H) :- !.

getElem(Pos, [_|T], Elem) :-
    Pos1 is Pos - 1,
    getElem(Pos1, T, Elem).

coliniaritate([X1, Y1], [X2, Y2], [X3, Y3]) :-
    Diff1 is Y3 - Y1,
    Diff2 is Y2 - Y1,
    Diff3 is X3 - X1,
    Diff4 is X2 - X1,
    Diff1 * Diff4 =:= Diff2 * Diff3.

conditiiAux(Points, [P1, P2|_], P3) :-
    getElem(P1, Points, A),
    getElem(P2, Points, B),
    getElem(P3, Points, C),
    coliniaritate(A, B, C).

conditii(Points, [P|T], P3) :-
    candidat(P, P3),
    P3 =\= P,
    conditiiAux(Points, [P|T], P3).

convert(_, [], []) :- !.

convert(Points, [H|T], [E|Elems]) :-
    getElem(H, Points, E),
    convert(Points, T, Elems).

backtrAux(Points, Elems, Positions) :-
    convert(Points, Positions, Elems).

backtrAux(Points, Subm, Col) :-
    conditii(Points, Col, P3),
    backtrAux(Points, Subm, [P3|Col]).

backtr(Points, Subm) :-
    lenList(Points, N),
    candidat(N, P1),
    candidat(P1, P2),
    P1 \= P2,
    backtrAux(Points, Subm, [P2, P1]).








