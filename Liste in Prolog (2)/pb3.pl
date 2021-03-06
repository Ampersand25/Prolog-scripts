% Problema 3
% a) Sa se sorteze o lista cu eliminarea dublurilor.
% De ex: [4 2 6 2 3 4] => [2 3 4 6]

% Specificare predicat part (predicat de partitionare a unei liste in
% doua subliste disjuncte (nu au elemente comune <=> intersectia lor
% este lista vida))

% definire tip (declaratie de domeniu pentru lista omogene):
% element = integer
% list    = element*

% specificare antet predicat (signatura predicatului):
% part(E: element, L: list, Less: list, Greater: list)
% INPUT : E, L          - parametrii de intrare
% OUTPUT: Less, Greater - parametrii de iesire (rezultate)

% preconditii (restrictii impuse asupra datelor de intrare):
% E - pivotul (elementul dupa care se face partitionarea listei L in
% doua subliste/parti care sunt la randul lor liste de valori intregi)
% L - lista care va fi partitionata in alte doua subliste (disjuncte)
% dupa pivotul/elementul E

% postconditii (descrierea rezultatelor):
% Less    - lista de elemente (numere intregi) care contine toate
% elementele din lista L care sunt mai mici strict decat elementul E
% Greater - lista de elemente (numere intregi) care contine toate
% elementele din lista L care sunt mai mari strict decat elementul E
% set(L) = Less U Greater, unde U - reuniunea a doua multimi
%                          set(L) - predicat care transforma lista L in
%                          multime
% Less n Greater = (), unde () - multimea/lista vida

% modele de flux:
% (i, i, i, i) - determinist (modelul de flux default al unui predicat
% Prolog)
% (i, i, o, o) - determinist (modelul de flux in care a fost
% scris/gandit predicatul)
% (i, i, o, i) - determinist
% (i, i, o, o) - determinist

% modelul matematic al predicatului (formula recurenta/recursiva de
% calcul)
% fie L = l1l2...ln (lista cu n elemente)
% part(E, l1l2...ln, Less, Greater) =
% - part(E, (), (), ()), daca L = () (adica n = 0)
% - part(E, l2...ln, Less, Greater), daca L <> () si l1 = E
% - part(E, l2...ln, l1 (+) Less, Greater), daca L <> () si l1 < E
% - part(E, l2...ln, Less, l1 (+) Greater), daca L <> () si l1 > E
part(_, [], [], []) :- !.

part(Pivot, [H|T], [H|Less], Greater) :-
    H < Pivot,
    !,
    part(Pivot, T, Less, Greater).
part(Pivot, [H|T], Less, [H|Greater]) :-
    H > Pivot,
    !,
    part(Pivot, T, Less, Greater).
part(Pivot, [_|T], Less, Greater) :-
    part(Pivot, T, Less, Greater).

% Specificare predicat conc (predicat utilizator/user care concateneaza
% doua liste numerice prin alipirea elementelor celei de a doua liste la
% finalul/sfarsitul primei liste si stocarea listei rezultat intr-o alta
% lista care va fi parametrul de iesire al predicatului)
% predicatul functioneaza si pentru liste non-numerice (cum ar fi liste
% de liste), caz in care cele doua liste de intrare (precum si lista
% rezultat) vor fi liste eterogene

% definire tip (declaratie de domeniu pentru lista eterogene):
% element = integer; list
% list    = element*

% specificare antet predicat (signatura predicatului):
% conc(A: heterogeneous list, B: heterogeneous list, LRez:
% heterogeneous list)
% INPUT : A, B - parametrii de intrare
% OUTPUT: LRez - parametru de iesire (rezultat)

% preconditii (restrictii impuse asupra datelor de intrare):
% A - prima lista, lista la care va fi concatenat continutul listei B
% B - a doua lista, lista care va fi concatenata la lista A

% postconditii (descrierea rezultatelor):
% LRez - lista care va contine concatenarea listei A la lista B
% elementele din lista A vor aparea primele in LRez (in ordinea in
% care acestea apar si in A), urmate de elementele din lista B (in
% ordinea in care acestea apar si in B)
% LRez = A (+) B

% modele de flux:
% (i, i, i) - determinist (modelul de flux implicit al unui predicat
% Prolog)
% (i, i, o) - determinist (modelul de flux in care a fost
% scris/gandit predicatul)
% (i, o, i) - determinist
% (o, i, i) - determinist
% (o, o, i) - determinist (din cauza taieturii, adica a predicatului
% standard cut), daca nu s-ar utiliza predicatul cut in clauze atunci
% predicatul ar fi nedeterminist (ar avea mai multe solutii) in acest
% model de flux

% modelul matematic al predicatului (formula recurenta/recursiva de
% calcul)
% fie A = a1a2...am - lista cu m elemente
% fie B = b1b2...bn - lista nu n elemente
% fie ()  - empty list (lista vida)
% fie (+) - operatia de adaugare a unui element intr-o lista
% conc(a1a2...am, B) = B                      , daca A = (), adica m = 0
%                    = A                      , daca B = (), adica n = 0
%                    = a1 (+) conc(a2...am, B), altfel
conc([], [], []) :- !.
conc(L, [], L) :- !.
conc([], L, L) :- !.

conc([H|T], L, [H|LRez]) :-
    conc(T, L, LRez).

% Specificare predicat qsort (predicat utilizator care sorteaza folosind
% algoritmul QuickSort (sortare rapida implementata folosind tehnica
% Divide et Impera (Divide and Conquer) bazata pe recursivitate) o lista
% omogena de numere intregi). Algoritmul nu sorteaza lista in-place
% (este out-of-place, in sensul ca foloseste memorie aditionala
% neconstanta pentru operatia de sortare a listei). Sortarea se face
% fara pastrarea dublurilor (lista rezultat (lista sortata) va fi o
% multime din punct de vedere al compozitiei acesteia)

% definire tip (declaratie de domeniu pentru lista omogene):
% element = integer
% list    = element*

% specificare antet predicat (signatura predicatului):
% qsort(L: homogeneous list, LSorted: homogeneous list)
% INPUT : L       - parametru de intrare
% OUTPUT: LSorted - parametru de iesire (rezultat)

% preconditii (restrictii impuse asupra datelor de intrare):
% L - lista pe care vrem sa o sortam/ordonam strict crescator prin
% eliminarea dublurilor fiecarui element

% postconditii (descrierea rezultatelor):
% LRez - un aranjament (permutare cu un anumit numar de elemente sau
% combinare in care ordinea conteaza, aranjamentele sunt combinari
% ordonate) al listei L cu proprietatea ca elementele sunt in ordine
% (strict) crescatoare si nu se repeta vreun element (fiecare element
% din LRez apare o singura data in aceasta lista si apare cel putin o
% data (o data sau de mai multe ori in lista L))

% modele de flux:
% (i, i) - determinist (modelul de flux implicit al unui predicat
% Prolog)
% (i, o) - determinist (modelul de flux in care a fost
% scris/gandit predicatul)

% modelul matematic al predicatului (formula recurenta/recursiva de
% calcul)
% fie L = l1l2...ln, lista cu n elemente valori intregi
% fie (+) - operatorul de concatenare a doua liste
% li cu i = 1..n (i = 1,n) este numar intreg (din Z - multimea numerelor
% intregi)
% qsort(L) = (), daca L = () (adica daca n = 0)
%          = qsort(Less) (+) (l1) (+) qsort(Greater), daca
%            L <> () (adica n > 0 <=> n >= 1) si unde
%            part(l1, l2...ln, Less, Greater) sau (Less, Greater) =
%            part(l1, l2...ln)
% (l1) - lista cu un singur element, ci anume elementul l1 (primul
% element din lista L)
qsort([], []) :- !.
qsort([H], [H]) :- !.
qsort([H|[H]], [H]) :- !.
qsort([H1|[H2]], [H1, H2]) :-
    H1 < H2,
    !.
qsort([H1|[H2]], [H2, H1]) :- !.

qsort([H|T], LSorted) :-
    Pivot = H,
    part(Pivot, T, Less, Greater),
    qsort(Less, LessSorted),
    qsort(Greater, GreaterSorted),
    conc(LessSorted, [Pivot|GreaterSorted], LSorted).

% Exemplu subpunctul a)
goal_a :- qsort([4, 2, 6, 2, 3, 4], [2, 3, 4, 6]).

% Testare predicat qsort in modelul de flux (i, i)
go10 :- qsort([], []).
go11 :- qsort([5], [5]).
go12 :- qsort([2, 4], [2, 4]).
go13 :- qsort([13, 6], [6, 13]).
go14 :- qsort([8, 8], [8]).
go15 :- qsort([9, 4, 6], [4, 6, 9]).
go16 :- qsort([1, 1, 1], [1]).
go17 :- qsort([7, 7, 4, 11, 5, 11, 3, 7, 2, 6, 4], [2, 3, 4, 5, 6, 7, 11]).
go18 :- qsort([1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5], [1, 2, 3, 4, 5]).
go19 :- qsort([6, 3, 8, 8, 8, 3, 4, 11, 20, 11, 15, 13, 7, 7], [3, 4, 6, 7, 8, 11, 13, 15, 20]).





% b) Se da o lista eterogena, formata din numere intregi si liste de numere.
% Sa se sorteze fiecare sublista fara pastrarea dublurilor.
% De ex: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7]
% => [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

% Specificare predicat sortSublists (predicat de tip user care sorteaza
% toate sublistele (inner lists) cu elemente valori numerice dintr-o
% lista (outer list), fara a modifica ordinea elementelor in lista
% principala)

% definire tip (declaratie de domeniu pentru lista eterogene):
% element = integer; list
% list    = element*

% specificare antet predicat (signatura predicatului):
% sortSublists(L: heterogeneous list, LRez: heterogeneous list)
% INPUT : L    - parametru de intrare
% OUTPUT: LRez - parametru de iesire (rezultat)

% preconditii (restrictii impuse asupra datelor de intrare):
% L - lista eterogena cu elemente numere intregi si liste de numere
% intregi

% postconditii (descrierea rezultatelor):
% LRez - lista eteronena cu elemente numere intregi si liste de numere
% intregi care se obtine din lista L, data ca si parametru de intrare
% predicatului, prin sortarea in ordine crescatoare fara pastrarea
% dublurilor a tuturor sublistelor din aceasta lista (elementele care nu
% sunt subliste (sunt numere intregi) isi vor pastra ordinea in cadrul
% listei finale/rezultat)

% modele de flux:
% (i, i) - determinist (modelul de flux implicit al unui predicat
% Prolog)
% (i, o) - determinist (modelul de flux in care a fost
% scris/gandit predicatul)

% (o, i) - determinist (sau nu)
% sortSublists(X, [3, [4, 3, 6, 1], 7]). => X = [3, [3, 4], 7]. (clauza
% de tip fact/fapt)
% sortSublists(X, [3, [4, 3], 7]).       => false.
% => NU ARE MODELUL (o, i) (nu functioneaza in acest model de flux)

% modelul matematic al predicatului (formula recurenta/recursiva de
% calcul)
% fie L = l1l2...ln, unde n este lungimea listei L (numarul de elemente
% din acestea)
% sortSublists(l1l2...ln) = (), daca L = () (adica n = 0)
%                         = l1 (+) sortSublists(l2...ln), daca L <> ()
%                         si l1 este numar
%                         = qsort(l1) (+) sortSublists(l2...ln), daca L
%                         <> () si l1 este lista (adica nu este numar)
sortSublists([], []) :- !.

sortSublists([H|T], [H|LRez]) :-
    number(H), % \+ is_list(H)
    !,
    sortSublists(T, LRez).
sortSublists([H|T], [HSorted|LRez]) :-
    qsort(H, HSorted),
    sortSublists(T, LRez).

% Exemplu subpunctul b)
goal_b :- sortSublists([1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7]).

% Testare predicat sortSublists in modelul de flux (i, i)
go20 :- sortSublists([], []).
go21 :- sortSublists([4], [4]).
go22 :- sortSublists([[4, 7, 4, 2, 2, 2]], [[2, 4, 7]]).
go23 :- sortSublists([9, [3, 6, 6, 3, 8]], [9, [3, 6, 8]]).
go24 :- sortSublists([[11, 5, 1, 6, 1, 11, 5, 5], 11], [[1, 5, 6, 11], 11]).
go25 :- sortSublists([[5, 3, 7, 5], [2, 1, 1, 9, 7, 1, 0]], [[3, 5, 7], [0, 1, 2, 7, 9]]).
go26 :- sortSublists([3, 7, 1, [6, 8, 3, 4], 9, [], [1, 1, 6, 4, 6]], [3, 7, 1, [3, 4, 6, 8], 9, [], [1, 4, 6]]).
go27 :- sortSublists([[6], [7, 3], 8, [5, 5, 5], 9, 8, 3, [1, 2, 3], 4], [[6], [3, 7], 8, [5], 9, 8, 3, [1, 2, 3], 4]).
go28 :- sortSublists([[], [], []], [[], [], []]).
go29 :- sortSublists([5, [6, 3, 8, 2, 3, 8, 6], 1, 1, [9, 2, 9, 9, 1, 2], 2, 6, 2, [10, 7, 11, 4, 16, 3]], [5, [2, 3, 6, 8], 1, 1, [1, 2, 9], 2, 6, 2, [3, 4, 7, 10, 11, 16]]).









