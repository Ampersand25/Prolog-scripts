% 7b. Sa se scrie un predicat care, primind o lista, intoarce multimea
% tuturor perechilor din lista. De ex, cu [a, b, c, d] va produce[[a,
% b], [a, c], [a, d], [b, c], [b, d], [c, d]].

pairsFirstEl([], []) :- !.
pairsFirstEl([_], []) :- !.
pairsFirstEl([H1|[H2|[]]], [[H1, H2]]) :- !.

pairsFirstEl([H1|[H2|T]], L) :-
    pairsFirstEl([H1|T], L_),
    L = [[H1, H2]|L_].

conc([], [], []) :- !.
%conc([H], [], [H]) :- !.
%conc([], [H], [H]) :- !.
conc([], L, L) :- !.
conc(L, [], L) :- !.

/*
conc([H|T], L, [H|Rez]) :-
    conc(T, L, Rez).
*/

conc([H|T], L, Rez) :-
    conc(T, L, Rez_),
    Rez = [H|Rez_].

pairs([], [[]]) :- !.
pairs([_], [[]]) :- !.
pairs([H1|[H2|[]]], [[H1, H2]]) :- !.

pairs([H|T], P) :-
    pairsFirstEl([H|T], L_),
    pairs(T, P_),
    conc(L_, P_, P).





/*
pair([], []).
pair([_|[]], []).
pair([H1|[H2|[]]], [[H1, H2]]).

pair([H1|[H2|T]], [[H1, H2]|L1]) :-
    pair([H1|T], L1).

computeAllPairs([], []).
computeAllPairs([_|[]], []).
computeAllPairs([H1|[H2|[]]], [[H1, H2]]).

computeAllPairs([H|T], [L, L1]) :-
    pair([H|T], L),
    computeAllPairs(T, L1).
*/



