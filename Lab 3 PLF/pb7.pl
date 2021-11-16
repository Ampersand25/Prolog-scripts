/*
7. Sa se genereze lista aranjamentelor de K elemente, cu elementele unei
liste date.
Ex: [2,3,4] K=2 => [[2,3], [3,2], [2,4], [4,2], [3,4], [4,3]] (nu
neaparat in aceasta ordine)
*/

candidat(E, [E|_]).

candidat(E, [_|T]) :-
    candidat(E, T).

reverseListRec([], Col, Col) :- !.

reverseListRec([H|T], LReversed, Col) :-
    reverseListRec(T, LReversed, [H|Col]).

reverseList([], []) :- !.
reverseList([H|[]], [H]) :- !.
reverseList([H1|[H2]], [H2, H1]) :- !.

reverseList(L, LReversed) :-
    reverseListRec(L, LReversed, []).

conditii(L, K, Len, H, E, LenPlus) :-
    candidat(E, L),
    E \= H,
    LenPlus is Len + 1,
    LenPlus =< K.

backtrAux(_, K, Sol, K, Col) :-
    !,
    reverseList(Col, Sol).

backtrAux(L, K, Sol, 0, []) :-
    candidat(E, L),
    backtrAux(L, K, Sol, 1, [E]).

backtrAux(L, K, Sol, Len, [H|T]) :-
    conditii(L, K, Len, H, E, LenPlus),
    backtrAux(L, K, Sol, LenPlus, [E|[H|T]]).

backtrRec(L, K, Sol) :-
    backtrAux(L, K, Sol, 0, []).

backtr(L, K, LSol) :-
    write('Lista aranjamentelor de '),
    write(K),
    write(' elemente cu elementele listei '),
    write(L),
    write(' este:'),
    nl,
    findall(Sol, backtrRec(L, K, Sol), LSol).





