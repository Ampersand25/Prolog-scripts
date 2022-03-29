/*
7. Sa se genereze lista aranjamentelor de K elemente, cu elementele unei
liste date.
Ex: [2,3,4] K=2 => [[2,3], [3,2], [2,4], [4,2], [3,4], [4,3]] (nu
neaparat in aceasta ordine)
*/

candidat(N, N) :-
    N >= 1.

candidat(N, K) :-
    N > 1,
    N1 is N - 1,
    candidat(N1, K).

membership(E, [E|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

sizeList([], 0) :- !.
sizeList([_|[]], 1) :- !.
sizeList([_, _], 2) :- !.

sizeList([_|T], Size) :-
    sizeList(T, Size1),
    Size is Size1 + 1.

getElement([], _, false) :- !.
getElement([H|_], 1, H) :- !.

getElement([_|T], Nr, Rez) :-
    Nr1 is Nr - 1,
    getElement(T, Nr1, Rez).

convert(_, [], []) :- !.

convert(L, [H|T], [E|Sol]) :-
    getElement(L, H, E),
    convert(L, T, Sol).

conditii(Size, K, Len, Col, E, Len1) :-
    candidat(Size, E),
    \+ membership(E, Col),
    Len1 is Len + 1,
    Len1 =< K.

backtrAux(L, _, K, Sol, K, Col) :-
    !,
    convert(L, Col, Sol).

backtrAux(L, Size, K, Sol, Len, Col) :-
    conditii(Size, K, Len, Col, E, Len1),
    backtrAux(L, Size, K, Sol, Len1, [E|Col]).

backtrRec(L, K, Sol) :-
    sizeList(L, Size),
    candidat(Size, E),
    backtrAux(L, Size, K, Sol, 1, [E]).

backtr(L, K, LSol) :-
    findall(Sol, backtrRec(L, K, Sol), LSol).





















