/*
candidat([H|_], H).

candidat([_|T], E) :-
    candidat(T, E).

backtrAux(_, Subm, Subm).

backtrAux(L, Subm, [H|T]) :-
    candidat(L, Candidat),
    Candidat < H,
    backtrAux(L, Subm, [Candidat|[H|T]]).

backtr(L, Subm) :-
    candidat(L, Candidat),
    backtrAux(L, Subm, [Candidat]).
*/

candidat(N, K) :-
    N > 1,
    N1 is N - 1,
    candidat(N1, K).

candidat(N, N).

lenList([], 0) :- !.

lenList([_|T], Len) :-
    lenList(T, Len1),
    Len is Len1 + 1.

getElement(1, [H|_], H) :- !.

getElement(Pos, [_|T], El) :-
    Pos1 is Pos - 1,
    getElement(Pos1, T, El).

convert([], _, []) :- !.

convert([H|T], Elems, [Element|Subm]) :-
    getElement(H, Elems, Element),
    convert(T, Elems, Subm).

backtrAux(L, Subm, _, Col) :-
    convert(Col, L, Subm).

backtrAux(L, Subm, N, []) :-
    candidat(N, Candidat),
    backtrAux(L, Subm, N, [Candidat]).

backtrAux(L, Subm, N, [H|T]) :-
    candidat(N, Candidat),
    Candidat < H,
    backtrAux(L, Subm, N, [Candidat|[H|T]]).

backtr(L, Subm) :-
    lenList(L, N),
    backtrAux(L, Subm, N, []).


