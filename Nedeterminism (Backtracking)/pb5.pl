/*
5. Sa se genereze lista submultimilor cu N elemente, cu elementele unei liste date. Ex: [2,3,4] N=2 => [[2,3],[2,4],[3,4]]
*/

candidat([H|_], Candidat) :-
    Candidat = H.

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

conditii(L, N, NrElems, H, E, NrElemsPlus) :-
    NrElems < N,
    candidat(L, E),
    E < H,
    NrElemsPlus is NrElems + 1.

backtrAux(_, N, Col, N, Col) :- !.

backtrAux(L, N, Sol, NrElems, [H|Col]) :-
    conditii(L, N, NrElems, H, E, NrElemsPlus),
    backtrAux(L, N, Sol, NrElemsPlus, [E|[H|Col]]).

backtrRec(L, N, Sol) :-
    candidat(L, E),
    backtrAux(L, N, Sol, 1, [E]).

typeMsg(L, N) :-
    write('Lista submultimilor cu '),
    write(N),
    write(' elemente ale multimii '),
    write(L),
    write(' este:'),
    nl.

backtr(L, N, LSol) :-
    typeMsg(L, N),
    findall(Sol, backtrRec(L, N, Sol), LSol).








