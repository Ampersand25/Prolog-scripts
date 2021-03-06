% a)
eCresc([]) :- !.
eCresc([_|[]]) :- !. % eCresc([_]) :- !.
eCresc([H1|[H2|[]]]) :-
    H1 < H2,
    !.

eCresc([H1|[H2|T]]) :-
    H1 < H2,
    eCresc([H2|T]).

transform([], []) :- !.
transform([_], []) :- !.
transform([H|[H]], [H, H]) :- !.
transform([H1|[H2|[]]], [H2]) :-
    H1 < H2,
    !.
transform([_, _], []) :- !.

transform([H1|[H2|T]], LRez) :-
    H1 > H2,
    !,
    transform([H2|T], LRez).
transform(L, L) :- !.

len([], 0) :- !.
len([_|[]], 1) :- !. % len([_], 1) :- !.

len([_|T], L) :-
    len(T, L1),
    L is L1 + 1.

eVale([H1|[H2|T]]) :-
    H1 > H2,
    L = [H1|[H2|T]],
    transform(L, L_),
    \+ len(L_, 0),
    eCresc(L_).

% b)
sumAltRec([], 0) :- !.
sumAltRec([H|[]], H) :- !.
sumAltRec([H1, H2], Diff) :-
    !,
    Diff is H1 - H2.

sumAltRec([H1|[H2|L]], Sum) :-
    Diff is H1 - H2,
    sumAltRec(L, Sum_),
    Sum is Diff + Sum_.

















