% a)
insertEl(L, E, 0, [E|L]) :- !.
insertEl([], E, _, [E]) :- !.
%insertEl([], _, _, []) :- !.
insertEl(L, E, 1, [E|L]) :- !.

insertEl([H|T], E, N, [H|LRez]) :-
    N1 is N - 1,
    insertEl(T, E, N1, LRez).

% b)
gcd(A, 0, A) :- !.

gcd(A, B, GCD) :-
    MOD is A mod B, % GCD is mod(A, B)
    gcd(B, MOD, GCD).

gcdListRec([], GCD, GCD) :- !.

gcdListRec([H|T], GCD, Rez) :-
    gcd(H, GCD, GCD_),
    gcdListRec(T, GCD_, Rez).

gcdList([], -1) :- !.
gcdList([H], H) :- !.
gcdList([H1, H2], GCD) :-
    !,
    gcd(H1, H2, GCD).

gcdList([H|T], GCD) :-
    gcdListRec(T, H, GCD).
