% a)
pred([]) :- !.

pred([_|[_|T]]) :-
    pred(T).

% b)
minListRec([], MIN, MIN) :- !.

minListRec([H|T], MIN, Rez) :-
    H < MIN,
    !,
    minListRec(T, H, Rez).
minListRec([_|T], MIN, Rez) :-
    minListRec(T, MIN, Rez).

minList([], -1) :- !.
minList([H], H) :- !. % minList([H|[]], H) :- !.
minList([H1, H2], H1) :-
    H1 =< H2,
    !.
minList([_, H2], H2) :- !.

minList([H|T], MIN) :-
    minListRec(T, H, MIN).

deleteFirstMinRec([], _, []) :- !.
deleteFirstMinRec([MIN|T], MIN, T) :- !.

deleteFirstMinRec([H|T], MIN, [H|LRez]) :-
    deleteFirstMinRec(T, MIN, LRez).

deleteFirstMin(L, LRez) :-
    minList(L, MIN),
    deleteFirstMinRec(L, MIN, LRez).

