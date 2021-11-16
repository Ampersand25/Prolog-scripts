pred([], []) :- !.

pred([H|_], H) :-
    \+ is_list(H), % number(H)
    !.
pred([_|T], L) :-
    pred(T, L).

