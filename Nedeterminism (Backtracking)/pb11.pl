/*
11. Sa se genereze toate subsirurile de lungime 2n+1, formate doar din 0, -1 sau 1, astfel incat a1 = 0, ..., a2n+1= 0 si | ai+1 ? ai| = 1 sau 2, pentru orice 1 <= i <= 2n.
*/

candidat([H|_], H).

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

/*
conditie(Num) :-
    Num == 1, % Num = 1,
    !.

conditie(Num) :-
    Num == 2. % Num =:= 2.
*/

conditie(Num) :-
    Num >= 1,
    Num =< 2.

modul(A, A) :-
    A > 0,
    !.

modul(A, Modul) :-
    Modul is A * (-1).

conditieGen(E1, E2) :-
    Diff is E1 - E2,
    modul(Diff, DiffModul),
    conditie(DiffModul).

conditii(Len, Candidati, LenCurr, H, Candidat, LenCurr1) :-
    candidat(Candidati, Candidat),
    conditieGen(Candidat, H),
    LenCurr1 is LenCurr + 1,
    LenCurr1 =< Len.

backtrAux(Len, _, [0|T], Len, [0|T]) :- !.

backtrAux(Len, Candidati, Sol, LenCurr, [H|T]) :-
    conditii(Len, Candidati, LenCurr, H, Candidat, LenCurr1),
    backtrAux(Len, Candidati, Sol, LenCurr1, [Candidat|[H|T]]).

backtrRec(Len, Candidati, Sol) :-
    backtrAux(Len, Candidati, Sol, 1, [0]).

init(N, Candidati, Len) :-
    N >= 0,
    Candidati = [0, -1, 1],
    Len is 2 * N + 1.

backtr(N, Sol) :-
    init(N, Candidati, Len),
    backtrRec(Len, Candidati, Sol).



