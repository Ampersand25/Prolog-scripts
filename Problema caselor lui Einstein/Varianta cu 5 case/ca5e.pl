candidat([_|T], Candidat) :-
    candidat(T, Candidat).

candidat([H|_], H).

generateAux(L1, L2, L3, L4, L5, [C1, C2, C3, C4, C5]) :-
    candidat(L1, C1),
    candidat(L2, C2),
    candidat(L3, C3),
    candidat(L4, C4),
    candidat(L5, C5).

c_1([red, brit, _, _, _]).

constraint_1([C1, C2, C3, C4, C5]) :-
    c_1(C1);
    c_1(C2);
    c_1(C3);
    c_1(C4);
    c_1(C5).

c_2([_, swede, _, _, dog]).

constraint_2([C1, C2, C3, C4, C5]) :-
    c_2(C1);
    c_2(C2);
    c_2(C3);
    c_2(C4);
    c_2(C5).

c_3([_, dane, tea, _, _]).

constraint_3([C1, C2, C3, C4, C5]) :-
    c_3(C1);
    c_3(C2);
    c_3(C3);
    c_3(C4);
    c_3(C5).

c_4([green, _, _, _, _], [white, _, _, _, _]).

constraint_4([C1, C2, C3, C4, C5]) :-
    c_4(C1, C2);
    c_4(C2, C3);
    c_4(C3, C4);
    c_4(C4, C5).

c_5([green, _, coffee, _, _]).

constraint_5([C1, C2, C3, C4, C5]) :-
    c_5(C1);
    c_5(C2);
    c_5(C3);
    c_5(C4);
    c_5(C5).

c_6([_, _, _, pm, bird]).

constraint_6([C1, C2, C3, C4, C5]) :-
    c_6(C1);
    c_6(C2);
    c_6(C3);
    c_6(C4);
    c_6(C5).

c_7([yellow, _, _, dunhill, _]).

constraint_7([C1, C2, C3, C4, C5]) :-
    c_7(C1);
    c_7(C2);
    c_7(C3);
    c_7(C4);
    c_7(C5).

constraint_8([_, _, [_, _, milk, _, _], _, _]).

constraint_9([[norwegian, _, _, _, _], _, _, _, _]).

c_10([_, _, _, _, cat], [_, _, _, blend, _]) :- !.
c_10([_, _, _, blend, _], [_, _, _, _, cat]).

constraint_10([C1, C2, C3, C4, C5]) :-
    c_10(C1, C2);
    c_10(C2, C3);
    c_10(C3, C4);
    c_10(C4, C5).

c_11([_, _, _, _, horse], [_, _, _, dunhill, _]).

c_11_cntr(Cm, Cn) :-
    c_11(Cm, Cn);
    c_11(Cn, Cm).

constraint_11([C1, C2, C3, C4, C5]) :-
    c_11_cntr(C1, C2);
    c_11_cntr(C2, C3);
    c_11_cntr(C3, C4);
    c_11_cntr(C4, C5).

c_12([_, _, beer, bm, _]).

constraint_12([C1, C2, C3, C4, C5]) :-
    c_12(C1);
    c_12(C2);
    c_12(C3);
    c_12(C4);
    c_12(C5).

c_13([_, german, _, prince, _]).

constraint_13([C1, C2, C3, C4, C5]) :-
    c_13(C1);
    c_13(C2);
    c_13(C3);
    c_13(C4);
    c_13(C5).

c_14([_, norwegian, _, _, _], [blue, _, _, _, _]).

constraint_14([C1, C2, C3, C4, C5]) :-
    c_14(C1, C2);
    c_14(C2, C1);
    c_14(C2, C3);
    c_14(C3, C2);
    c_14(C3, C4);
    c_14(C4, C3);
    c_14(C4, C5);
    c_14(C5, C4).

c_15([_, _, _, blend, _], [_, _, water, _, _]) :- !.
c_15([_, _, water, _, _], [_, _, _, blend, _]).

constraint_15([C1, C2, C3, C4, C5]) :-
    c_15(C1, C2);
    c_15(C2, C3);
    c_15(C3, C4);
    c_15(C4, C5).

test(Col) :-
    constraint_1(Col),
    constraint_2(Col),
    constraint_3(Col),
    constraint_4(Col),
    constraint_5(Col),
    constraint_6(Col),
    constraint_7(Col),
    constraint_8(Col),
    constraint_9(Col),
    constraint_10(Col),
    constraint_11(Col),
    constraint_12(Col),
    constraint_13(Col),
    constraint_14(Col),
    constraint_15(Col).

diffLists([], [_|_]) :- !.
diffLists([_|_], []) :- !.
diffLists([H1], [H2]) :-
    !,
    H1 \= H2.

diffLists([H1|T1], [H2|T2]) :-
    H1 \= H2,
    diffLists(T1, T2).

conditiiAux(_, []) :- !.

conditiiAux(L, [H|T]) :-
    diffLists(L, H),
    conditiiAux(L, T).

conditii(L1, L2, L3, L4, L5, Len, Col, LenPlusPlus, NewComp) :-
    Len =< 4,
    generateAux(L1, L2, L3, L4, L5, NewComp),
    conditiiAux(NewComp, Col),
    LenPlusPlus is Len + 1.

generateRec(_, _, _, _, _, Col, 5, Col) :-
    !,
    test(Col).

generateRec(L1, L2, L3, L4, L5, Sol, Len, Col) :-
    conditii(L1, L2, L3, L4, L5, Len, Col, LenPlusPlus, NewComp),
    generateRec(L1, L2, L3, L4, L5, Sol, LenPlusPlus, [NewComp|Col]).

generateInit(L1, L2, L3, L4, L5, Sol) :-
    generateAux(L1, L2, L3, L4, L5, S),
    generateRec(L1, L2, L3, L4, L5, Sol, 1, [S]).

generate(Sol) :-
    Colors = [red, green, blue, white, yellow],
    Owners = [brit, swede, dane, norwegian, german],
    Beverages = [tea,  coffee, milk, beer, water],
    Cigars = [pm, dunhill, blend, bm, prince],
    Pets = [dog, bird, cat, horse, fish],
    generateInit(Colors, Owners, Beverages, Cigars, Pets, Sol).










