search(X, cons(X, _)).
search(X, cons(_, T)) :- search(X, T).

search2(X, cons(X, cons(X, _))).
search2(X, cons(_, T)) :- search2(X, T).

search_two(X, cons(X, cons(Y, cons(X, _)))).
search_two(X, cons(_, T)) :- search_two(X, T).

search_anytwo(E, cons(E, T)) :- search(E, T).
search_anytwo(E, cons(F, T)) :- E\=F, search_anytwo(E, T).

size(nil, zero).
size(cons(H, T), s(PARZIALE)) :- size(T, PARZIALE).

sum(X, zero, X).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).

sum_list(nil, zero).
sum_list(cons(H, nil), H).
sum_list(cons(H, T), TOTALE) :- sum_list(T, PARZIALE), sum(H, PARZIALE, TOTALE). 

count(List, E, N) :- count(List, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E\=E2, count(L, E2, N, M).

greater(s(_), zero).
greater(s(X), s(Y)) :-  greater(X, Y).

max(List, Max) :- max(List, zero, Max).
max(cons(H, nil), TempMax, H).
max(cons(H, T), TempMax, OUTPUT) :- max(T, TempMax, OUTPUT), greater(OUTPUT, H).
max(cons(H, T), TempMax, H) :- max(T, TempMax, OUTPUT), greater(H, OUTPUT).

minMax(cons(H, T), Min, Max) :- minMax(T, H, H, Min, Max).
minMax(nil, Max, Min, Min, Max).
minMax(cons(H, T), TempMax, TempMin, Min, Max) :- greater(H, TempMax), minMax(T, H, TempMin, Min, Max).
minMax(cons(H, T), TempMax, TempMin, Min, Max) :- greater(TempMin, H), minMax(T, TempMax, H, Min, Max).
minMax(cons(_, T), TempMax, TempMin, Min, Max) :- minMax(T, TempMax, TempMin, Min, Max).

same(nil, nil).
same(cons(H, T), cons(H, T1)) :- same(T, T1).

all_bigger(nil, nil).
all_bigger(cons(H, T), cons(H1, T1)) :- greater(H, H1), all_bigger(T, T1).

sublist(cons(H, nil), List) :- search(H, List).
sublist(cons(H, T), List2) :- search(H, List2), sublist(T, List2).


seq(zero, _, nil).
seq(s(N), E, cons(E, T)) :- seq(N, E, T).

seqR(zero, nil).
seqR(s(N), cons(N, OUTPUT)) :- seqR(N, OUTPUT).

last(nil, X, cons(X, nil)).
last(cons(H, nil), X, cons(H, cons(X, nil))).
last(cons(H, T), X, cons(H, OUTPUT)) :- last(T, X, OUTPUT).

seqR2(zero, nil).
seqR2(s(zero), cons(zero, nil)).
seqR2(s(X), RES) :- seqR2(X, OUTPUT), last(OUTPUT, X, RES).

lastElement(cons(H, nil), H).
lastElement(cons(_, T), OUTPUT) :- lastElement(T, OUTPUT).

map(cons(X, nil), s(X)).
map(cons(R, T), cons(s(R),V)) :- map(T, V).


filter(cons(X, nil), cons(X,nil)) :- greater(X, zero).
filter(cons(X, nil), nil).
filter(cons(H, T), cons(H, V)) :- filter(T, V), greater(H, zero).
filter(cons(H, T), V) :- filter(T, V).

countElements(nil, zero).
countElements(cons(H, T), s(OUTPUT)) :- countElements(T, OUTPUT), greater(H, zero).
countElements(cons(H, T), OUTPUT) :- countElements(T, OUTPUT).















