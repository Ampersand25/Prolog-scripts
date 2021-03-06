/*
EXEMPLU 1.5 PROBLEMA CELOR 3 CASE.
1. Englezul locuiește ȋn prima casă din stȃnga.
2. Ȋn casa imediat din dreapta celei ȋn care se află lupul se fumează Lucky Strike.
3. Spaniolul fumează Kent.
4. Rusul are cal.
Cine fumează LM? Al cui este cȃinele?
*/

candidat([H|_], H).

candidat([_|T], C) :-
    candidat(T, C).

diffLists([], [_|_]) :- !.
diffLists([_|_], []) :- !.
diffLists([H1|[]], [H2|[]]) :-
    !,
    H1 \= H2.

diffLists([H1|T1], [H2|T2]) :-
    H1 \= H2,
    diffLists(T1, T2).

equLists([], []) :- !.

equLists([H|T1], [H|T2]) :-
    equLists(T1, T2).

generateAux(L1, L2, L3, [C1, C2, C3]) :-
    candidat(L1, C1),
    candidat(L2, C2),
    candidat(L3, C3).

conditiiContinuare(S, [S1|[]]) :-
    !,
    diffLists(S, S1).

conditiiContinuare(S, [S1, S2]) :-
    diffLists(S, S1),
    diffLists(S, S2).

constraint_1([[eng, _,_], _, _]).

c_2([_, lup, _], [_, _, ls]).

constraint_2([L1, L2|[L3]]) :-
    c_2(L1, L2);
    c_2(L2, L3).

c_3([spa, _, ken]).

constraint_3([L1|[L2, L3]]) :-
    c_3(L1);
    c_3(L2);
    c_3(L3).

c_4([rus, cal, _]).

constraint_4([L1|[L2|[L3]]]) :-
    c_4(L1);
    c_4(L2);
    c_4(L3).

test(Col) :-
    constraint_1(Col),
    constraint_2(Col),
    constraint_3(Col),
    constraint_4(Col).

generateRec(_, _, _, Col, 3, Col) :-
    !,
    test(Col).

generateRec(L1, L2, L3, Sol, Len, Col) :-
    Len < 3, % Len =< 2,
    generateAux(L1, L2, L3, S),
    conditiiContinuare(S, Col),
    Len1 is Len + 1,
    generateRec(L1, L2, L3, Sol, Len1, [S|Col]).

generateInit(L1, L2, L3, Sol) :-
    generateAux(L1, L2, L3, S1),
    generateRec(L1, L2, L3, Sol, 1, [S1]).

generate(Sol) :-
    N = [eng, spa, rus],
    A = [caine, lup, cal],
    T = [lm, ls, ken],
    generateInit(N, A, T, Sol).




