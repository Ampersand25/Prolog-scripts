% a)
sub([], _, _, []) :- !.
sub([E], E, L, L) :- !. % sub([E|[]], E, L, L) :- !.
sub([H], _, _, [H]) :- !. % sub([H|[]], _, _, [H]) :- !.

sub([E|T], E, L, [L|LRez]) :-
    !,
    sub(T, E, L, LRez).
sub([H|T], E, L, [H|LRez]) :-
    sub(T, E, L, LRez).

% b)
deleteN([], _, []) :- !.
deleteN([_], 1, []) :- !.
deleteN([_|T], 1, T) :- !.

deleteN([H|T], N, [H|LRez]) :-
    N1 is N - 1,
    deleteN(T, N1, LRez).
