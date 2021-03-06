/*
13. "Colorarea hartilor".
Se dau n tari.
Se cer toate modalitatile de colorarea celor n tari cu m culori, astfel inca doua tari vecine sa nu fie colorate la fel.
*/

/*
Exemplu:
backtr(['Ungaria', 'Belarus', 'Spania'], ['rosu', 'verde'], Sol).
backtr(['San Marino', 'Belgia', 'Suedia'], ['galben', 'albastru',
'violet', 'portocaliu'], Sol).
backtr(['Serbia', 'Bulgaria'], ['turcoaz', 'maro', 'mov'], Sol).
*/

candidat([H|_], H).

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

lenList([], 0) :- !.

lenList([_|T], Len) :-
    lenList(T, Len1),
    Len is Len1 + 1.

conditii(N, Tari, Culori, Len, ColTari, [[_, CuloareCol]|_], Tara, Culoare, LenPlus) :-
    candidat(Tari, Tara),
    \+ candidat(ColTari, Tara),
    candidat(Culori, Culoare),
    Culoare \= CuloareCol,
    LenPlus is Len + 1,
    LenPlus =< N.

typeSolutionText(Cont, H1, H2) :-
    write(Cont),
    write(': '),
    write(H1),
    write(' - '),
    write(H2),
    nl.

printSolutionRec([], _) :- !.

printSolutionRec([[H1|[H2]]|T], Cont) :-
    typeSolutionText(Cont, H1, H2),
    Cont1 is Cont + 1,
    printSolutionRec(T, Cont1).

printSolution(Sol) :-
    printSolutionRec(Sol, 1).

backtrAux(N, _, _, Col, N, _, Col) :-
    !,
    printSolution(Col).

backtrAux(N, Tari, Culori, Sol, Len, ColTari, ColSol) :-
    conditii(N, Tari, Culori, Len, ColTari, ColSol, Tara, Culoare, LenPlus),
    backtrAux(N, Tari, Culori, Sol, LenPlus, [Tara|ColTari], [[Tara, Culoare]|ColSol]).

typeMsg(Tari, Culori) :-
    write('Colorarile tarilor '),
    write(Tari),
    write(' cu culorile '),
    write(Culori),
    write(' sunt:'),
    nl.

backtr(Tari, Culori, Sol) :-
    typeMsg(Tari, Culori),
    candidat(Tari, Tara),
    candidat(Culori, Culoare),
    lenList(Tari, N),
    backtrAux(N, Tari, Culori, Sol, 1, [Tara], [[Tara, Culoare]]).











