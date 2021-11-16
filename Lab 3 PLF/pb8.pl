/*
8. Un jucator la PRONOSPORT vrea sa aleaga pronosticuri pentru 4 meciuri.
Pronosticurile pot fi 1,X,2.
Sa se genereze toate variantele posibile stiind ca:
- ultimul pronostic nu poate fi 2
- sa nu fie mai mult de doua pronosticuri X.
*/

candidat([H|_], H).

candidat([_|T], E) :-
    candidat(T, E).

appendToList([], E, [E]) :- !.

appendToList([H|T], E, [H|LRez]) :-
    appendToList(T, E, LRez).

invertList([], []) :- !.
invertList([H|[]], [H]) :- !.
invertList([H1, H2|[]], [H2, H1]) :- !.

invertList([H|T], LInverted) :-
    invertList(T, TInverted),
    appendToList(TInverted, H, LInverted).

conditiiFinale(1) :- !.
conditiiFinale('X') :- !.

countElemInList([], _, 0) :- !.

countElemInList([H|T], H, ContRez) :-
    !,
    countElemInList(T, H, Cont),
    ContRez is Cont + 1.
countElemInList([_|T], E, Cont) :-
    countElemInList(T, E, Cont).

conditiiIntermediare(_, 1) :- !.
conditiiIntermediare(_, 2) :- !.
conditiiIntermediare(Col, 'X') :-
    countElemInList(Col, 'X', Freq),
    Freq < 2.

conditiiContinuare(P, Nr, Lg, Col, C) :-
    Lg < Nr,
    candidat(P, C),
    conditiiIntermediare(Col, C).

backtrAux(_, Nr, Sol, Nr, Last, Col) :-
    conditiiFinale(Last),
    !,
    invertList(Col, Sol).

backtrAux(P, Nr, Sol, Lg, _, Col) :-
    conditiiContinuare(P, Nr, Lg, Col, C),
    LgPlusPlus is Lg + 1,
    backtrAux(P, Nr, Sol, LgPlusPlus, C, [C|Col]).

backtrGen(P, Nr, Sol) :-
    candidat(P, Candidat),
    backtrAux(P, Nr, Sol, 1, Candidat, [Candidat]).

backtr(Sol) :-
    Pronosticuri = [1, 'X', 2],
    NrMeciuri = 4,
    write('Pronosticurile posibile pentru cele 4 meciuri sunt:'),
    nl,
    backtrGen(Pronosticuri, NrMeciuri, Sol).







