% a)
gcd(A, 0, A) :- !.

gcd(A, B, GCD) :-
    MOD is mod(A, B),
    gcd(B, MOD, GCD).

gcdAlt(A, A, A) :- !.

gcdAlt(A, B, GCD) :-
    A > B,
    !,
    A_ is A - B,
    gcdAlt(A_, B, GCD).
gcdAlt(A, B, GCD) :-
    B_ is B - A,
    gcdAlt(A, B_, GCD).

cmmmc(A, B, R) :-
    Prod is A * B,
    gcd(A, B, GCD),
    R is div(Prod, GCD).

cmmmcListRec([], Col, Col) :- !.

cmmmcListRec([H|T], Col, R) :-
    cmmmc(H, Col, Col_),
    cmmmcListRec(T, Col_, R).

cmmmcList([], 0) :- !.
cmmmcList([H|[]], H) :- !.
cmmmcList([H1|[H2|[]]], R) :-
    !,
    cmmmc(H1, H2, R).

cmmmcList([H|T], R) :-
    cmmmcListRec(T, H, R).

% b)
addList([], _, _, _, []) :- !.

addList([H|T], Idx, Pos, V, [H|[V|LRez]]) :-
    Idx == Pos, % Idx = Pos
    !,
    IdxNext is Idx + 1,
    PosNext is Pos * 2,
    addList(T, IdxNext, PosNext, V, LRez).
addList([H|T], Idx, Pos, V, [H|LRez]) :-
    IdxNext is Idx + 1,
    addList(T, IdxNext, Pos, V, LRez).

addListGen(L, V, LRez) :-
    addList(L, 1, 1, V, LRez).








