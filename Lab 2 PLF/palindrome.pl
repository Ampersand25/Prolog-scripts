reverseRec(0, Rev, Rev) :- !.

reverseRec(N, Rev, Result) :-
    Rev_ is Rev * 10 + N mod 10,
    N_ is N div 10,
    reverseRec(N_, Rev_, Result).

reverse(N, N) :-
    N < 10,
    !.

reverse(N, Rev) :-
    reverseRec(N, 0, Rev).

isPalindrome(N) :-
    N < 10,
    !.

isPalindrome(N) :-
    reverse(N, Rev),
    N == Rev. % N = Rev

palindromes([], 0) :- !.
palindromes([H|[]], 0) :-
    \+ isPalindrome(H),
    !.
palindromes([_], 1) :- !.


palindromes([H|T], Cont) :-
    isPalindrome(H),
    !,
    palindromes(T, Cont_),
    Cont is Cont_ + 1.
palindromes([_|T], Cont) :-
    palindromes(T, Cont).

pred([], 0) :- !.

pred([H|T], Cont) :-
    number(H),
    !,
    pred(T, Cont).
pred([H|T], Cont) :-
    palindromes(H, Num),
    pred(T, Cont_),
    Cont is Cont_ + Num.








