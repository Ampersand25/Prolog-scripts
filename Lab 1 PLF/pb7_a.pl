% 7a. Sa se scrie un predicat care intoarce reuniunea a doua multimi.

% Varianta in care multimile nu sunt neaparat sortate/ordonate (strict)
% crescator si nici nu le sortam in corpul predicatului principal
searchElementInList(H, [H|_]) :- !.
%searchElementInList(X, [H|_]) :- X == H, !.

searchElementInList(E, [_|T]) :-
    % Specificare predicat searchElementInList

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element = integer
    % list    = element*

    % specificare antet predicat (signatura predicatului):
    % searchElementInList(E: element, L: list)

    % modelul matematic (formula recurenta/recursiva):
    % fie L = l1l2...ln, o lista cu n elemente, unde n este un numar natural (adica n >= 0)
    % => searchElementInList(E, L) = searchElementInList(E, l1l2...ln)
    % vom nota prin () - lista vida (lista cu 0 elemente), adica lista [] (singura lista considerata atom in limbajul Prolog)
    % searchElementInList(E, l1l2...ln) = true , daca E = l1
    %                                   = false, daca L = () (n = 0)
    %                                   = searchElementInList(E, l2...ln), in caz contrar (E <> l1 si n <> 0)

    % preconditii (restrictii impuse asupra datelor de intrare):
    % E - elementul cautat in lista L de numere, numar intreg
    % L - lista in care se face cautarea elementului E, lista de numere intregi

    % postconditii (descrierea rezultatelor):
    % searchElementInList returneaza o valoare booleana (valoare logica de adevar), adica true (daca elementul E se afla in lista L) sau false (daca elementul E nu se afla in lista L)
    % predicatul doar testeaza daca elementul E dat ca si parametru de intrare se afla in lista L data tot ca si parametru de intrare (membership in a list)

    % modele de flux:
    % (i, i) = (input, input)  - determinist (verifica daca o valoare data ca si parametru/argument de intrare se afla in lista pentru care se apeleaza predicatul)
    % (o, i) = (output, input) - determinist (are o singura solutie, ci anume primul element din lista data ca si al doilea parametru in apelul predicatului, sau returneaza false daca lista este vida (nu are un head, adica cap de lista), caz in care toate goal-urile au dat fail)

    searchElementInList(E, T).

reunionRec([], [], []) :- !.
reunionRec([H|T], [], [H|T]) :- !.
reunionRec([], [H|T], [H|T]) :- !.
% reunionRec([H], [], [H]) :- !.
% reunionRec([], [H], [H]):- !.

reunionRec([H1|T1], L2, R) :-
    % Specificare predicat reunionRec

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element = integer
    % list    = element*

    % specificare antet predicat (signatura predicatului):
    % fie L1 = [H1|T1] - lista formata din doua parti: H1 (head) si T1 (tail)
    % H1: element - capul listei L1 (un singur element)
    % T1: list    - coada listei L1 (o lista de elemente, care este sublista a lui L1, mai precis sublista lui L1 care nu contine primul element (capul listei, adica H1))
    % reunionRec(L1: list, L2: list, R: list)

    % modelul matematic (formula recurenta/recursiva):
    % conventii: (+) - operatia de adaugare (append) a unui element intr-o lista (operatie binara(cu doi operanzi))
    %            daca A este un element si L este o lista de elemente atunci
    %            A (+) L - se adauga elementul A la inceputul listei L
    %            L (+) A - se adauga eleemtnul A la finalul/sfarsitul listei L
    %            ()  - lista vida (empty list)
    %            L1 se va scrie l11l12...l1n, cu n numar natural (n - numarul de elemente din L1)
    %            L2 se va scrie l21l22...l2m, cu m numar natural (m - numarul de elemente din L2)
    % reunionRec(l11l12...l1n, l21l22...l2m) = L2 , daca L1 = () si L2 <> ()
    %                                        = L1 , daca L1 <> () si L2 = ()
    %                                        = (), daca L1 = () si L2 = ()
    %                                        = l11 (+) reunionRec(l12...l1n, l21l22...l2m), daca l11 nu apartine listei (l21l22...l2m) = L2
    %                                        = reunionRec(l12...l1n, l21l22...l2m), in caz contrar

    % preconditii (restrictii impuse asupra datelor de intrare):
    % L1 - lista de numere intregi pe care vrem sa o reunim cu lista L2
    % L1 trebuie sa fie multime (sa nu aiba doua elemente egale), nu neaparat sortata/ordonata (ordinea nu conteaza)
    % L2 - lista de numere intregi pe care vrem sa o reunim cu lista L1
    % L2 trebuie sa fie multime (sa nu aiba doua elemente egale), nu neaparat sortata/ordonata (ordinea nu conteaza)

    % postconditii (descrierea rezultatelor):
    % R - lista de numere intregi (elemente de tip intreg)
    % R este rezultatul intors/returnat de catre predicat (daca se da ca si data de iesire in modelul (i, i, o))
    % R reprezinta o multime reprezentata ca si o lista cu proprietatea ca R s-a obtinut prin reuniunea celor doua liste L1 si L2 (care sunt la randul lor multimi de numere intregi), elementele din R nu sunt intr-o ordine anume (acestea sunt distribuite in mod arbitrar/aleator)
    % R contine numere intregi care nu se repeta (proprietatea de multime)
    % daca n este numarul de elemente din L1, m este numarul de elemente din L2 si k este numarul de elemente din R, atunci urmatoarea relatie este satisfacuta:
    % min(n, m) <= k <= n + m

    % modele de flux:
    % (i, i, i) = (input, input, input)  - determinist (verifica daca a treia lista reprezinta reuniunea primelor doua liste)
    % (i, i, o) = (input, input, output) - determinist (are o solutie singulara, ci anume lista R, rezultata in urma aplicarii operatiei matematice de reuniune (operatie binara) intre cele doua multimi reprezentate sub forma de liste numerice: L1 si L2)

    searchElementInList(H1, L2),
    !,
    reunionRec(T1, L2, R).
reunionRec([H1|T1], L2, R) :-
    reunionRec(T1, L2, R_),
    R = [H1|R_].

% Varianta cu predicatul standard member si cu apelul predicatului cut
% (taietura) dupa auto-apelul predicatului
/*
reunionRec([H1|T1], L2, R) :-
    member(H1, L2),
    reunionRec(T1, L2, R),
    !;
    %\+(member(H1, L2)),
    reunionRec(T1, L2, R_),
    R = [H1|R_].
*/

reunion(L1, L2, R) :-
    % Specificare predicat reunion

    % definire tip (declaratie de domeniu pentru lista omogena):
    % element = integer
    % list    = element*

    % specificare antet predicat (signatura predicatului):
    % reunion(L1: list, L2: list, R: list)

    % pasi de aplicare a predicatului:
    % 1. calcularea reuniunii dintre listele L1 si L2 precum si salvarea (stocarea) listei rezultat in lista R_ (lista intermediara in rezolvarea problemei/taskului) prin apelul predicatului reunionRec (L1 si L2 vor fi date de intrare, iar R_ va fi data de iesire)
    % 2. sortarea listei intermediare R_ prin apelul predicatului standard (predefinit) sort (R_ va fi data de intrare, iar R va fi data de iesire sau rezultat al acestui predicat) si stocarea listei sortate in lista (termen compus) R

    % preconditii (restrictii impuse asupra datelor de intrare):
    % L1 - prima lista pe care vrem sa o reunim cu cea de a doua lista numerica (L2), lista de numere intregi
    % L1 trebuie sa fie multime (sa nu contina dubluri de elemente)
    % L2 - a doua lista pe care vrem sa o reunim cu prima lista numerica (L1), lista de numere intregi
    % L2 trebuie sa fie multime (sa nu contina dubluri de elemente)

    % postconditii (descrierea rezultatelor):
    % R  - lista rezultat obtinuta in urma reuniunii listelor L1 si L2, lista de numere intregi
    % R reprezinta reuniunea dintre listele L1 si L2 (R = L1 U L2), astfel ca R va fi la randul ei o multime (nu vor exista duplicate, adica fiecare element va fi unic in cadrul secventei) ca si L1 si respectiv L2, in plus, R va fi sortata/ordonata in mod crescator (intr-o multime nu conteaza ordinea, de aceea o multime este o colectie (un container) neordonata de date care nu se repeta)
    % daca n este numarul de elemente din L1, m este numarul de elemente din L2 si k este numarul de elemente din R, atunci are loc urmatoarea inegalitate:
    % min(n, m) <= k <= n + m

    % modele de flux:
    % (i, i, i) = (input, input, input)  - determinist (verifica daca a treia lista reprezinta reuniunea primelor doua liste si este si sortata/ordonata strict crescator)
    % (i, i, o) = (input, input, output) - determinist (are o solutie singulara, ci anume lista R, rezultata in urma aplicarii operatiei matematice de reuniune (operatie binara) intre cele doua multimi reprezentate sub forma de liste numerice: L1 si L2 si in urma unei sortari crescatoare)

    reunionRec(L1, L2, R_),
    sort(R_, R).

% Creare de interogari (queries)
% Intrebari (obiective/goal-uri)
go0 :- reunion([], [], []).
go1 :- reunion([4], [], [4]).
go2 :- reunion([], [1], [1]).
go3 :- reunion([2, 7], [], [2, 7]).
go4 :- reunion([], [8, 3, 5], [3, 5, 8]).
go5 :- reunion([4, 7, 1, 9], [11, 2, 0], [0, 1, 2, 4, 7, 9, 11]).
go6 :- reunion([21, 48, 37], [37, 21, 48], [21, 37, 48]).
go7 :- reunion([8, 1, 6, 11, 13], [9, 2, 1, 14, 13, 11, 12, 22], [1, 2, 6, 8, 9, 11, 12, 13, 14, 22]).
go8 :- reunion([3, 6, 9, 1, 4, 2, 8], [6, 1, 9, 2], [1, 2, 3, 4, 6, 8, 9]).
go9 :- reunion([7, 1, 8], [7, 4, 1, 3, 10, 9, 8, 0], [0, 1, 3, 4, 7, 8, 9, 10]).





% Varianta in care sortam/ordonam multimile prin apelul predicatului
% standard (predefinit) sort in predicatul principal (main)
% reunionSortedController, inainte de apelul predicatului utilizator
% reunionSorted, definit pentru a reuni doua multimi sortate/ordonate
% strict crescator
reunionSorted([], [], []) :- !.
reunionSorted([H|T], [], [H|T]) :- !.
reunionSorted([], [H|T], [H|T]) :- !.
% reunionSorted([H], [], [H]) :- !.
% reunionSorted([], [H], [H]) :- !.

/*
reunionSorted([H1|T1], [H2|T2], [H|T3]) :-
    H1 < H2,
    H = H1, % <=> H is H1
    reunionSorted(T1, [H2|T2], T3),
    !;
    H1 > H2,
    H = H2, % <=> H is H2
    reunionSorted([H1|T1], T2, T3),
    !;
    H1 == H2,
    H = H1, % <=> H is H1 (sau H is H2)
    reunionSorted(T1, T2, T3).
*/

reunionSorted([H1|T1], [H2|T2], [H1|T3]) :-
    H1 < H2,
    !,
    reunionSorted(T1, [H2|T2], T3).
reunionSorted([H1|T1], [H2|T2], [H2|T3]) :-
    H1 > H2,
    !,
    reunionSorted([H1|T1], T2, T3).
reunionSorted([H1|T1], [_|T2], [H1|T3]) :-
    !, % in acest caz (fiind pe ultima ramura), predicatul cut (taietura) poate sa lipseasca (nu afecteaza/influenteza executia)
    reunionSorted(T1, T2, T3).

reunionSortedController(L1, L2, R) :-
    sort(L1, L1Sorted),
    sort(L2, L2Sorted),
    reunionSorted(L1Sorted, L2Sorted, R).










