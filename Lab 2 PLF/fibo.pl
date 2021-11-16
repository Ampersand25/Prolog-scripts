fibo(0, 0) :- !.
fibo(1, 1) :- !.

fibo(N, K) :-
    N1 is N - 1,
    N2 is N - 2,
    fibo(N1, K1),
    fibo(N2, K2),
    K is K1 + K2.
