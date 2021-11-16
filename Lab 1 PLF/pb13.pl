% a)
membership(E, [E|_]) :- !.

membership(E, [_|T]) :-
    membership(E, T).

toSet([], []) :- !.
toSet([H|[]], [H]) :- !.
toSet([H|[H]], [H]) :- !.
toSet([H1|[H2|[]]], [H1, H2]) :- !.

toSet([H|T], L) :-
    membership(H, T),
    !,
    toSet(T, L).
toSet([H|T], [H|L]) :-
    toSet(T, L).

go :- toSet([1, 2, 3, 1, 2], [3, 1, 2]).

% b)
gcd(A, A, A) :- !.
gcd(A, 0, A) :- !.
gcd(0, A, A) :- !.

gcd(A, B, GCD) :-
    A =< B,
    !,
    B_ is B - A,
    gcd(A, B_, GCD).
gcd(A, B, GCD) :-
    A_ is A - B,
    gcd(A_, B, GCD).

gcdListRec([], GCD, GCD) :- !.

gcdListRec([H|T], GCD, Rez) :-
    gcd(H, GCD, GCD_),
    gcdListRec(T, GCD_, Rez).

gcdList([], -1) :- !.
gcdList([H], H) :- !.
gcdList([H1, H2], GCD) :-
    !,
    gcd(H1, H2, GCD). % gcd(H2, H1, GCD).

gcdList([H|T], GCD) :-
    gcdListRec(T, H, GCD).


