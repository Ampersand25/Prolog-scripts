/*
10. Se da sirul a1,..., an cu elemente numere intregi distincte.
Se cere sa se determine toate submultimile avand suma divizibila cu n.
*/

candidat(H, [H|_]).

candidat(E, [_|T]) :-
    candidat(E, T).

isDivisible(Sum, N) :-
    Mod is mod(Sum, N), % Mod is Sum mod N,
    Mod = 0.            % Mod == 0.

conditii(L, Sum, H, E, Sum1) :-
    candidat(E, L),
    E < H,
    Sum1 is E + Sum.

backtrRec(_, N, Col, Sum, Col) :-
    isDivisible(Sum, N).

backtrRec(L, N, Sol, Sum, [H|T]) :-
    conditii(L, Sum, H, E, Sum1),
    backtrRec(L, N, Sol, Sum1, [E|[H|T]]).

backtr(L, N, Sol) :-
    candidat(E, L),
    backtrRec(L, N, Sol, E, [E]).










