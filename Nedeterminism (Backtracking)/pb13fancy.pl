/*
13. "Colorarea hartilor".
Se dau n tari.
Se cer toate modalitatile de colorarea celor n tari cu m culori, astfel inca doua tari vecine sa nu fie colorate la fel.
*/


candidat([H|_], H).

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

getElementPosition(H, [H|_], 0) :- !.

getElementPosition(E, [_|T], Pos) :-
    getElementPosition(E, T, Pos1),
    Pos is Pos1 + 1.

lenList([], 0) :- !.
lenList([_|[]], 1) :- !.
lenList([_, _|[]], 2) :- !.

lenList([_|T], Len) :-
    lenList(T, Len1),
    Len is Len1 + 1.

conditii(N, Tari, Culori, Len, [H|_], [[_, CuloareCol]|_], Tara, TaraIDX, Culoare, LenPlus) :-
    Len < N,
    candidat(Tari, Tara),
    getElementPosition(Tara, Tari, TaraIDX),
    TaraIDX < H,
    candidat(Culori, Culoare),
    Culoare \= CuloareCol,
    LenPlus is Len + 1.

backtrAux(N, _, _, Col, N, _, _, Col) :- !.

backtrAux(N, Tari, Culori, Sol, Len, ColTari, PosTari, ColSol) :-
    conditii(N, Tari, Culori, Len, PosTari, ColSol, Tara, TaraIDX, Culoare, LenPlus),
    backtrAux(N, Tari, Culori, Sol, LenPlus, [Tara|ColTari], [TaraIDX|PosTari], [[Tara, Culoare]|ColSol]).

init(Tari, Culori, Tara, NrTari, Culoare, Position) :-
    candidat(Tari, Tara),
    candidat(Culori, Culoare),
    lenList(Tari, NrTari),
    getElementPosition(Tara, Tari, Position).

backtr(Tari, Culori, Sol) :-
    init(Tari, Culori, Tara, NrTari, Culoare, Position),
    backtrAux(NrTari, Tari, Culori, Sol, 1, [Tara], [Position], [[Tara, Culoare]]).








