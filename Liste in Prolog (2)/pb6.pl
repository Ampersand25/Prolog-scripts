appendList([], [], []) :- !.
appendList(L, [], L) :- !.
appendList([], L, L) :- !.

appendList([H|T], L2, [H|LRez]) :-
    appendList(T, L2, LRez).

insertList([], [], LRez) :-
    !,
    LRez = [].
insertList(L, [], LRez) :-
    !,
    LRez = L.
insertList([], L, LRez) :-
    !,
    LRez = L.

insertList(L, [H|T], [H|LRez]) :-
    insertList(L, T, LRez).

membership([X|_], X) :- !.

membership([_|T], X) :-
    membership(T, X).

inloc([], _, _, []) :- !.

% predicat principal subpunctul a)
/*
inloc([H|T], E, L1, [H|LRez]) :-
    H \= E,
    !,
    inloc(T, E, L1, LRez).
inloc([_|T], E, L1, LRez) :-
    \+ membership(E, L1),
    !,
    insertList(T, L1, T1),
    inloc(T1, E, L1, LRez).
*/

inloc([H|T], E, L1, LRez) :-
    H == E,
    !,
    inloc(T, E, L1, L),
    appendList(L1, L, LRez).
inloc([H|T], E, L1, [H|LRez]) :-
    inloc(T, E, L1, LRez).

% testare predicat subpunctul a)
goal_a :- inloc([1, 2, 1, 3, 1, 4], 1, [10, 11], [10, 11, 2, 10, 11, 3, 10, 11, 4]).

firstElement([H|_], H) :- !.

pred([], _, []) :- !.

% predicat principal subpunctul b)
pred([H|T], L, LRez) :-
    \+ is_list(H), % number(H),
    !,
    pred(T, L, LRezTail),
    LRez = [H|LRezTail].
pred([H|T], L, [L_|LRez]) :-
    firstElement(H, El),
    inloc(H, El, L, L_),
    pred(T, L, LRez).

% testare predicat subpunctul b)
goal_b :- pred([1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [11, 11], [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]).









