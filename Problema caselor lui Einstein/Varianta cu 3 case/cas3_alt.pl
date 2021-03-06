/*
EXEMPLU 1.5 PROBLEMA CELOR 3 CASE.
1. Englezul locuiește ȋn prima casă din stȃnga.
2. Ȋn casa imediat din dreapta celei ȋn care se află lupul se fumează Lucky Strike.
3. Spaniolul fumează Kent.
4. Rusul are cal.
Cine fumează LM? Al cui este cȃinele?
*/

candidat([_|T], Candidat) :-
    candidat(T, Candidat).

candidat([H|_], Candidat) :-
    Candidat = H.

diffLists([], [_|_]) :- !.
diffLists([_|_], []) :- !.
diffLists([H1|[]], [H2]) :-
    !,
    H1 \= H2.

diffLists([H1|T1], [H2|T2]) :-
    H1 \= H2,
    diffLists(T1, T2).

backtrAux(L1, L2, L3, [C1, C2, C3]) :-
    candidat(L1, C1),
    candidat(L2, C2),
    candidat(L3, C3).

constraint_1(2, [_, _, _]) :- !.
constraint_1(3, [eng, _, _]).

constraint_2([_, lup, _], [_, _, ls], [_, _, _]) :- !.
constraint_2([_, _, _], [_, lup, _], [_, _, ls]).

constraint_2_wrapper(2, _, _) :- !.

constraint_2_wrapper(3, C1, [C2, C3]) :-
    constraint_2(C1, C2, C3).

constraint_3([spa, _, ken]) :- !.
constraint_3([spa, _, _]) :- !, false.
constraint_3([_, _, ken]) :- !, false.
constraint_3([_, _, _]).

constraint_4([rus, cal, _]) :- !, true.
constraint_4([rus, _, _]) :- !, false.
constraint_4([_, cal, _]) :- !, false.
constraint_4([_, _, _]) :- true.

conditiiContinuareAux(S, [S1|[]]) :-
    !,
    diffLists(S, S1).

conditiiContinuareAux(S, [S1, S2]) :-
    diffLists(S, S1),
    diffLists(S, S2).

constraints(Len1, S, Col) :-
    constraint_1(Len1, S),
    constraint_2_wrapper(Len1, S, Col),
    constraint_3(S),
    constraint_4(S).

conditiiContinuare(L1, L2, L3, Len, Col, Len1, S) :-
    Len < 3, % Len =< 2,
    backtrAux(L1, L2, L3, S),
    conditiiContinuareAux(S, Col),
    Len1 is Len + 1,
    constraints(Len1, S, Col).

backtrRec(_, _, _, Col, 3, Col) :- !.

backtrRec(L1, L2, L3, Sol, Len, Col) :-
    conditiiContinuare(L1, L2, L3, Len, Col, Len1, S),
    backtrRec(L1, L2, L3, Sol, Len1, [S|Col]).

backtrInit(L1, L2, L3, Sol) :-
    backtrAux(L1, L2, L3, Comp),
    backtrRec(L1, L2, L3, Sol, 1, [Comp]).

backtr(Sol) :-
    N = [eng, spa, rus],
    A = [caine, lup, cal],
    T = [lm, ls, ken],
    backtrInit(N, A, T, Sol).



