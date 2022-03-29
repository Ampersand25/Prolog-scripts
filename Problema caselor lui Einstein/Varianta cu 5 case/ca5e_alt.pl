candidat([_|T], Candidat) :-
    candidat(T, Candidat).

candidat([H|_], Candidat) :-
    Candidat = H.

backtrAux(L1, L2, L3, L4, L5, [C1, C2, C3, C4, C5]) :-
    candidat(L1, C1),
    candidat(L2, C2),
    candidat(L3, C3),
    candidat(L4, C4),
    candidat(L5, C5).

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

constraint_1([red, brit, _, _, _]) :- !.
constraint_1([_, brit, _, _, _]) :- !, false.
constraint_1([red, _, _, _, _]) :- !, false.
constraint_1([_, _, _, _, _]).

constraint_2([_, swede, _, _, dog]) :- !.
constraint_2([_, _, _, _, dog]) :- !, false.
constraint_2([_, swede, _, _, _]) :- !, false.
constraint_2([_, _, _, _, _]).

constraint_3([_, dane, tea, _, _]) :- !.
constraint_3([_, _, tea, _, _]) :- !, false.
constraint_3([_, dane, _, _, _]) :- !, false.
constraint_3([_, _, _, _, _]).

constraint_5([green, _, coffee, _, _]) :- !.
constraint_5([_, _, coffee, _, _]) :- !, false.
constraint_5([green, _, _, _, _]) :- !, false.
constraint_5([_, _, _, _, _]).

constraint_6([_, _, _, pm, bird]) :- !.
constraint_6([_, _, _, _, bird]) :- !, false.
constraint_6([_, _, _, pm, _]) :- !, false.
constraint_6([_, _, _, _, _]).

constraint_7([yellow, _, _, dunhill, _]) :- !.
constraint_7([_, _, _, dunhill, _]) :- !, false.
constraint_7([yellow, _, _, _, _]) :- !, false.
constraint_7([_, _, _, _, _]).

constraint_8(1, _) :- !.
constraint_8(2, _) :- !.
constraint_8(4, _) :- !.
constraint_8(5, _) :- !.
constraint_8(3, [_, _, milk, _, _]).

constraint_9(1, _) :- !.
constraint_9(2, _) :- !.
constraint_9(3, _) :- !.
constraint_9(4, _) :- !.
constraint_9(5, [_, norwegian, _, _, _]).

constraint_12([_, _, beer, bm, _]) :- !.
constraint_12([_, _, _, bm, _]) :- !, false.
constraint_12([_, _, beer, _, _]) :- !, false.
constraint_12([_, _, _, _, _]).

constraint_13([_, german, _, prince, _]) :- !.
constraint_13([_, _, _, prince, _]) :- !, false.
constraint_13([_, german, _, _, _]) :- !, false.
constraint_13([_, _, _, _, _]).

constraints(Len, Comp) :-
    constraint_1(Comp),
    constraint_2(Comp),
    constraint_3(Comp),
    constraint_5(Comp),
    constraint_6(Comp),
    constraint_7(Comp),
    constraint_8(Len, Comp),
    constraint_9(Len, Comp),
    constraint_12(Comp),
    constraint_13(Comp).

conditii(L1, L2, L3, L4, L5, Len, Col, LenPlusPlus, NewComp) :-
    Len =< 4,
    backtrAux(L1, L2, L3, L4, L5, NewComp),
    conditiiAux(NewComp, Col),
    LenPlusPlus is Len + 1,
    constraints(LenPlusPlus, NewComp).

c_4([green, _, _, _, _], [white, _, _, _, _]).

constraint_4([C1, C2, C3, C4, C5]) :-
    c_4(C1, C2);
    c_4(C2, C3);
    c_4(C3, C4);
    c_4(C4, C5).

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
    constraint_4(Col),
    constraint_10(Col),
    constraint_11(Col),
    constraint_14(Col),
    constraint_15(Col).

backtrRec(_, _, _, _, _, Col, 5, Col) :-
    !,
    test(Col).

backtrRec(L1, L2, L3, L4, L5, Sol, Len, Col) :-
    conditii(L1, L2, L3, L4, L5, Len, Col, LenPlusPlus, NewComp),
    backtrRec(L1, L2, L3, L4, L5, Sol, LenPlusPlus, [NewComp|Col]).

backtrInit(L1, L2, L3, L4, L5, Sol) :-
    backtrAux(L1, L2, L3, L4, L5, Comp),
    constraints(1, Comp),
    backtrRec(L1, L2, L3, L4, L5, Sol, 1, [Comp]).

backtr(Sol) :-
    Colors = [red, green, blue, white, yellow],
    Owners = [brit, swede, dane, norwegian, german],
    Beverages = [tea,  coffee, milk, beer, water],
    Cigars = [pm, dunhill, blend, bm, prince],
    Pets = [dog, bird, cat, horse, fish],
    backtrInit(Colors, Owners, Beverages, Cigars, Pets, Sol).















