/*
14. Sa se scrie un program care genereaza lista submultimilor de suma S data,cu elementele unei liste.
Ex: [1,2,3,4,5,6,10] si S=10 => [[1,2,3,4], [1,4,5], [2,3,5], [4,6], [10]]
(nu neaparat in aceasta ordine)
*/

candidat([H|_], H).

candidat([_|T], E) :-
    candidat(T, E).

conditii(L, S, SumCurr, H, SumCurrNew, E) :-
    candidat(L, E),
    E < H,
    SumCurrNew is SumCurr + E,
    SumCurrNew =< S.

backtrRec(_, S, Sol, S, Sol) :- !.

backtrRec(L, S, Sol, SumCurr, [H|T]) :-
    conditii(L, S, SumCurr, H, SumCurrNew, E),
    backtrRec(L, S, Sol, SumCurrNew, [E|[H|T]]).

backtrGen(L, S, Sol) :-
    candidat(L, E),
    E =< S,
    backtrRec(L, S, Sol, E, [E]).

backtr(L, S, Sol) :-
    write('Lista submultimilor de suma '),
    write(S),
    write(' cu elemente din lista '),
    write(L),
    write(' este:'),
    nl,
    findall(Subm, backtrGen(L, S, Subm), Sol).





