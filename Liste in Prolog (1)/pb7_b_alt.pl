% 7b. Sa se scrie un predicat care, primind o lista, intoarce multimea
% tuturor perechilor din lista. De ex, cu [a, b, c, d] va produce[[a,
% b], [a, c], [a, d], [b, c], [b, d], [c, d]].

% predicatul makePair - auxiliar
% predicat nedeterminist
makePair(_, [], []):- !.
makePair(E, [H|[]], [E, H]) :- !.

% Varianta I
makePair(E, [H|_], L) :-
    % Specificare predicat makePair

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element = integer
    % list    = element*

    % specificare antet predicat (signatura predicatului):
    % fie L1 = [H|_] cu H - capul (head-ul) listei (primul element) si _ o variabila anonima care reprezinta coada listei (poate sa fie chiar si lista vida [] - empty list)
    % makePair(E: element, L1: list, L2: list)

    % fie L1 = l1l2...ln, cu n numar natural si lk: element (pentru k numar natural si 1 <= k <= n, lk reprezinta elementul k din lista L1)
    % in continuare, vom nota cu () lista vida (lista cu 0 elemente)
    % aceasta lista se reprezinta in Prolog prin [] (empty list)
    % predicatul este definit in modul urmator:
    % makePair(E, L1)        =
    % makePair(E, l1l2...ln) =
    % 1. L <- ()     , daca L1 este lista vida (n = 0 sau L1 = ())
    %    L <- (E, l1), daca L1 nu este lista vida (n > 0 <=> n >= 1 sau L1 <> ())
    % in L va fi stocata o pereche de elemente dintre care primul element este E (parametru de intrare pentru predicat) si al doilea element este capul listei L1 (primul element din aceasta)
    % 2. makePair(E, l2...ln) - apel recursiv/recurent (inductive/recursive step)
    % conditia de oprire/stop este atunci cand lista L1 este vida (base case = cazul de baza), in aceasta situatie se returneaza lista vida (empty list) in variabila X si se termina auto-apelurile predicatului. Daca lista L1 contine un singur element (care va fi capul listei, iar coada listei L1 este lista vida) atunci se returneaza lista formata din elementul E si capul listei L1 (se termina auto-apelurile si in acest caz => STOP)

    % pre (restrictii impuse asupra parametrilor de intrare):
    % E  - primul element din perechile pe care dorim sa le generam cu lista L1 de numere, numar intreg
    % L1 - lista de elemente intregi (valori numerice intregi), din L1 se alege al doilea element pentru perechile (listele de doua elemente) pe care vrem sa le generam cu argumentul E al predicatului (acesta va ocupa prima pozitie in cadrul perechilor)
    % L1 = [H|_]
    % H  - capul listei L1, numar intreg
    % _  - coada listei L1, lista de numere intregi (poate sa fie lista vida), reprezentata prin variabila anonima

    % post (descrierea rezultatelor):
    % predicatul intoarce in variabila L o lista compusa din doua elemente intregi, dintre care primul element este argumentul E al predicatului, iar al doilea este un membru al listei L1 (un element lk cu 1 <= k <= len(L1))
    % variabila L va lua pe rand valoarea tuturor perechilor neordonate (nu conteaa ordinea) de forma (E, li) cu i = 1,n, unde n este numarul de elemente din lista L1 si li este elementul de pe pozitia i din aceasta lista (al i-lea element)
    % L reprezinta o lista de doua elemente (o pereche)

    % modele de flux:
    % (i, o) = (input, output) - nedeterminist (are mai multe solutii, ci anume n (unde n este lungimea listei L1 = numarul de elemente din lista L1), cate una pentru fiecare pereche (lista de doua elemente) neordonata formata din elementul E si un element din lista L1)

    L = [E, H].
%Varianta II
/*
makePair(E, [H|_], [E, H]).
*/
makePair(E, [_|T], L) :-
    makePair(E, T, L).

% predicatul computePairs - auxiliar
% predicat nedeterminist care apeleaza predicatul makePair in mod direct
computePairs([], []) :- !.
computePairs([_|[]], []) :- !.
computePairs([H1|[H2|[]]], [H1, H2]) :- !.

computePairs([H|T], L) :-
    % Specificare predicat computePairs

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element = integer
    % list    = element*

    % specificare antet predicat (signatura predicatului):
    % fie L1 = [H|T] cu H - capul (head) listei (primul element) si T - coada (tail) listei (sublista formata din toate elementele listei, mai putin primul element (adica capul listei H))
    % H: element
    % T: list (element*)
    % computePairs(L1: list, L2: list)

    % fie L1 = l1l2...ln, cu n >= 0 numar intreg si l1, l2, ..., ln: element (intreg/integer)
    % predicatul este compus din urmatorii pasi:
    % computePairs(L1)        =
    % computePairs(l1l2...ln) =
    % 1. L <- makePair(l1, l2l3...ln)
    % in L va fi stocata o pereche (lista de doua elemente) de elemente din lista L1
    % 2. computePairs(l2l3...ln) - apel recursiv/recurent
    % conditia de oprire/stop este atunci cand lista L1 este vida (lista ()) sau este formata dintr-un singur element (base case = cazul de baza), in aceasta situatie se returneaza lista vida (empty list, adica [] - Prolog sau () - Pseudocod) in variabila X si se termina auto-apelurile predicatului

    % pre (restrictii impuse asupra parametrilor de intrare):
    % L1 - lista de elemente intregi (valori numerice intregi)
    % L1 = [H|T]
    % H  - capul listei L1, numar intreg
    % T  - coada listei L1, lista de numere intregi

    % post (descrierea rezultatelor):
    % predicatul intoarce in variabila L o lista compusa din doua elemente intregi, ambele fiind membrii in lista L1 (adica componente ale listei L1)
    % variabila L va lua pe rand valoarea tuturor perechilor neordonate (nu conteaa ordinea, adica perechea (a, b) este aceeasi cu perechea (b, a), unde a si b sunt doua elemente din lista L1 (doua valori numerice intregi)) de elemente din lista L1
    % L reprezinta o lista de doua elemente (o pereche de elemente, ambele din L1)
    % L este de forma (a, b) cu a apartine lui L1 si b apartine lui L1 si a <> b (cele doua elemente trebuie sa fie diferite, adica sa se afle pe pozitii distincte in lista L1, valoarea lor poate sa fie aceeasi in cazul in care sunt valori duplicate aflate la indici distincti in lista)

    % modele de flux:
    % (i, o) = (input, output) - nedeterminist (are mai multe solutii, cate una pentru fiecare pereche (lista de doua elemente) neordonata de elemente din lista data ca si argument de intrare in cadrul predicatului)

    makePair(H, T, L).
computePairs([_|T], L) :-
    computePairs(T, L).

% predicatul allPairs - principal (main)
% predicat determinist care apeleaza predicatul computePairs in mod
% direct si predicatul makePair in mod indirect (predicatul computePairs
% apeleaza predicatul makePair)
allPairs(L1, L2) :-
    % Specificare predicat allPairs

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element1 = integer
    % list1    = element1*
    % element2 = (integer, integer) = (element1, element1)
    % list2    = element2*

    % specificare antet predicat:
    % allPairs(L1: list1, L2: list2)

    % predicatul apeleaza in mod direct predicatul standard (predefinit) findall si returneaza/intoarce in variabila L2, lista tuturor solutiilor predicatului computePairs apelat pentru lista L1 ca si parametru (argument) de tip input (de intrare)
    % in variabila intermediara X va fi stocata una dintre solutiile predicatului nedeterminist computePairs (X este iesire pentru acest predicat) apelat pentru lista L1 (L1 este intrare pentru acest predicat), iar L2 va contine toate listele de tip X concatenate (alipite), adica o lista cu toate solutiile apelului predicatului computePairs pentru lista L1 (toate X-urile rezultate)

    % pre (restrictii impuse asupra parametrilor de intrare):
    % L1 - lista de elemente intregi (valori numerice intregi), lista din care vrem sa extragem toate perechile neordonate de elemente

    % post (descrierea rezultatelor):
    % L2 - rezultatul intors de catre predicat
    % L2 este o lista de perechi (liste de cate doua elemente, in care fiecare element este un numar intreg din lista L1)
    % L2 va contine toate perechile neordonate (nu conteaza ordinea) de elemente din L1
    % L2 va contine ca si elemente perechi (liste) de forma (li, lj) cu proprietatea ca 1 <= i < j <= n, unde n este numarul de elemente din lista L1 iar li si lj sunt doua elemente din aceasta lista (li este elementul de pe pozitia i din lista iar lj este elementul de pe pozitia j din lista)
    % daca L1 = (l1, l2, ..., ln), atunci L2 = ((l1, l2), (l1, l3), ..., (l1, ln), (l2, l3), (l2, l4), ..., (l2, ln), ..., (ln-1, ln))

    % modele de flux:
    % (i, i) = (input, input)  - determinist (verifica daca a doua lista contine toate perechile neordonate de elemente din prima lista)
    % (i, o) = (input, output) - determinist (are solutie unica ci anume o singura lista care contine toate perechile de elemente din lista data ca si parametru de intrare pentru predicat (la apel))

    % apelul predicatului standard (predefinit) findall
    findall(X, computePairs(L1, X), L2). % X - termen compus legat la unul din rezultatele predicatului nedeterminist computePairs apelat pentru lista L1 (intrare = input) si elementul (perechea) X (iesire = output). L2 reprezinta o lista formata din toate elementele X rezultate in urma apelului de predicat (in cazul nostru, toate perechile (liste cu exact doua elemente) neordonate (nu conteaza ordinea) de elemente din lista L1). L2 va fi o lista de liste de cate doua elemente fiecare. X este o lista (pereche) de forma [a, b], unde a si b sunt elemente (termeni/items) din lista L1.

% Creare de interogari (queries)
% Intrebari (obiective/goal-uri)
go0 :- allPairs([], [[]]).
go1 :- allPairs([3], [[]]).
go2 :- allPairs([74], [[]]).
go3 :- allPairs([381], [[]]).
go4 :- allPairs([4, 7], [[4, 7]]).
go5 :- allPairs([8, 3], [[8, 3]]).
go6 :- allPairs([5, 5], [[5, 5]]).
go7 :- allPairs([3, 5, 1], [[3, 5], [3, 1], [5, 1]]).
go8 :- allPairs([8, 4, 7, 8, 4], [[8, 4], [8, 7], [8, 8], [8, 4], [4, 7], [4, 8], [4, 4], [7, 8], [7, 4], [8, 4]]).
go9 :- allPairs([3, 3, 9, 5, 3, 5], [[3, 3], [3, 9], [3, 5], [3, 3], [3, 5], [3, 9], [3, 5], [3, 3], [3, 5], [9, 5], [9, 3], [9, 5], [5, 3], [5, 5], [3, 5]]).








