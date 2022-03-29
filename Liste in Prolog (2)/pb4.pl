mergeL([], [], []) :- !.
mergeL(L, [], L) :- !.
mergeL([], L, L) :- !.

% predicat principal subpunctul a)
mergeL([H1|T1], [H2|T2], LRez) :-
    H1 == H2, % H1 = H2 (H1 =:= H2)
    !,
    mergeL(T1, T2, L),
    LRez = [H1|L]. % LRez = [H2|L].
mergeL([H1|T1], [H2|T2], [H1|LRez]) :-
    H1 < H2,
    !,
    mergeL(T1, [H2|T2], LRez).
mergeL([H1|T1], [H2|T2], [H2|LRez]) :-
    mergeL([H1|T1], T2, LRez).

deleteDuplicates([], []) :- !.
deleteDuplicates([H], [H]) :- !.
deleteDuplicates([H|[H]], [H]) :- !.
deleteDuplicates([H1|[H2]], [H1, H2]) :- !.

deleteDuplicates([H|[H|T]], LRez) :-
    !,
    deleteDuplicates([H|T], LRez).
deleteDuplicates([H1|[H2|T]], [H1|LRez]) :-
    deleteDuplicates([H2|T], LRez).

aux([], Col, Col) :- !.

aux([H|T], Col, LRez) :-
    number(H), % \+ is_list(H),
    !,
    aux(T, Col, LRez).
aux([H|T], Col, LRez) :-
    % is_list(H), % \+ number(H),
    % !,
    deleteDuplicates(H, H_),
    mergeL(H_, Col, NewCol),
    aux(T, NewCol, LRez).

% predicat principal subpunctul b)
pred(L, LRez) :-
    aux(L, [], LRez).

% testare predicat subpunctul b)
goal :- pred([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8], [1, 2, 3, 4, 6, 7, 9, 10, 11]).
