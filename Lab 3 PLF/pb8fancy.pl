/*
8. Un jucator la PRONOSPORT vrea sa aleaga pronosticuri pentru 4 meciuri.
Pronosticurile pot fi 1,X,2.
Sa se genereze toate variantele posibile stiind ca:
- ultimul pronostic nu poate fi 2
- sa nu fie mai mult de doua pronosticuri X.
*/

candidat(H, [H|_]).

candidat(E, [_|T]) :-
    candidat(E, T).

invertListRec([], Col, Col) :- !.

invertListRec([H|T], Col, Sol) :-
    invertListRec(T, [H|Col], Sol).

invertList(L, LInverted) :-
    invertListRec(L, [], LInverted).

conditiiFinale(1) :- !.
conditiiFinale('X') :- !.

conditiiIntermediare(ContX) :-
    ContX =< 2.

updateX('X', ContX, NewContX) :-
    !,
    NewContX is ContX + 1.
updateX(_, ContX, ContX).

conditiiContinuare(P, Nr, Lg, ContX, C, NewContX) :-
    Lg < Nr,
    candidat(C, P),
    updateX(C, ContX, NewContX),
    conditiiIntermediare(NewContX).

backtrAux(_, Nr, Sol, Nr, Last, _, Col) :-
    conditiiFinale(Last),
    !,
    invertList(Col, Sol).

backtrAux(P, Nr, Sol, Lg, _, NrOfX, Col) :-
    conditiiContinuare(P, Nr, Lg, NrOfX, C, NewNrOfX),
    LgPlusPlus is Lg + 1,
    backtrAux(P, Nr, Sol, LgPlusPlus, C, NewNrOfX, [C|Col]).

value('X', 1) :- !.
value(_, 0).

backtrGen(P, Nr, Sol) :-
    candidat(Candidat, P),
    value(Candidat, NrOfX),
    backtrAux(P, Nr, Sol, 1, Candidat, NrOfX, [Candidat]).

backtr(Sol) :-
    Pronosticuri = [1, 'X', 2],
    NrMeciuri    = 4,
    write('Pronosticurile posibile pentru cele 4 meciuri sunt:'),
    nl,
    backtrGen(Pronosticuri, NrMeciuri, Sol).





