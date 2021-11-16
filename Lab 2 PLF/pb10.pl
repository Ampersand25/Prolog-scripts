addListRec([], _, _, _, []) :- !.

addListRec([H|T], Idx, Next, E, [H|[E|LRez]]) :-
    Idx == Next,
    !,
    IdxPlus is Idx + 1,
    NextExtra is Next * 2 + 1,
    addListRec(T, IdxPlus, NextExtra, E, LRez).
addListRec([H|T], Idx, Next, E, [H|LRez]) :-
    IdxPlus is Idx + 1,
    addListRec(T, IdxPlus, Next, E, LRez).

% predicat principal subpunctul a)
addList(L, E, LRez) :-
    addListRec(L, 1, 1, E, LRez).

func([], []) :- !.
func([H], [H]) :-
    number(H),
    !.
func([_], []) :- !.

% predicat principal subpunctul b)
func([H1|[H2|T]], [H1|LRez]) :-
    number(H1),
    number(H2),
    !,
    func([H2|T], LRez).
func([H1|[H2|T]], LRez) :-
    is_list(H1),
    number(H2),
    !,
    func([H2|T], LRez).
func([H1|[H2|T]], [H1|[L|LRez]]) :-
    number(H1),
    is_list(H2),
    !,
    addList(H2, H1, L),
    func([H2|T], LRez).
func(_, _) :-
    write('B r u h'),
    nl,
    write('nigga'),
    false.

% testam predicatul de la subpunctul b)
goal :- func([1, [2, 3], 7, [4, 1, 4], 3, 6, [7, 5, 1, 3, 9, 8, 2, 7], 5], [1, [2, 1, 3], 7, [4, 7, 1, 4, 7], 3, 6, [7, 6, 5, 1, 6, 3, 9, 8, 2, 6, 7], 5]).




