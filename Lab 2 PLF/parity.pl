isEven(0) :- !.

isEven(N) :-
    N > 0,
    N1 is N - 2,
    isEven(N1).

isOdd(N) :-
    \+ isEven(N).
