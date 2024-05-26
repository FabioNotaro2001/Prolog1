search2(X, [X, X|_]) :- !.
search2(X, [_|T]) :- search2(X, T).

search_two(X, [X, _, X | _]) :- !.
search_two(X, [_|T]) :- search_two(X, T).

size(List, Size) :- size(List, 0, Size).
size([], TEMP, TEMP).
size([_|T], TEMP, OUTPUT) :- S is TEMP + 1, size(T, S, OUTPUT).

sum([], 0).
sum([H|T], OUTPUT) :- number(H), sum(T, PARZIALE), OUTPUT is H + PARZIALE.

max([H|T], Max, Min) :- max(T, H, H, Max, Min), !.
max([], TEMPMAX, TEMPMIN, TEMPMAX, TEMPMIN).
max([H|T], TEMPMAX, TEMPMIN, Max, Min) :- H > TEMPMAX, max(T, H, TEMPMIN, Max, Min).
max([H|T], TEMPMAX, TEMPMIN, Max, Min) :- H < TEMPMIN, max(T, TEMPMAX, H, Max, Min).
max([H|T], TEMPMAX, TEMPMIN, Max, Min) :- max(T, TEMPMAX, TEMPMIN, Max, Min).

% Diverso da Bedei.
split([H|T], 1, [H], T).
split([H|T], X, [H|TEMP], List2) :- size([H|T], S), X =< S, S >= 1, B is X - 1, split(T, B, TEMP, List2).

rotate([], []).
rotate([H|T], OUTPUT) :- append(T, [H], OUTPUT).

interval(A, B, A).
interval(A, B, X) :- A2 is A + 1, A2 < B, interval(A2, B, X).
dice(X) :- interval(1, 7, ESTRATTO), X=ESTRATTO.

three_dice(X, [A, B, C]) :- dice(A), dice(B), dice(C), X is A + B + C. 

dropAny(X, [X|T], T).
dropAny(X, [H|Xs], [H|L]) :- dropAny(X, Xs, L).

dropFirst(X, [X|T], T) :- !.
dropFirst(X, [H|Xs], [H|L]) :- dropFirst(X, Xs, L).

dropLast(X, [H|Xs], [H|L]) :- dropLast(X, Xs, L), !.
dropLast(X, [X|T], T).

dropAll(_, [], []).
dropAll(X, [X|T], OUTPUT) :- dropAll(X, T, OUTPUT).
dropAll(X, [H|T], [H|OUTPUT]) :- X \= H, dropAll(X, T, OUTPUT).

fromList([_] ,[]).
fromList([H1, H2|T] ,[e(H1, H2)|L]) :- fromList([H2|T], L).

last([H|T], Elem) :- last(T, Elem).
last([X], X).
fromCircList([X], e(X, X)).
fromCircList([X, Y], [e(X, Y), e(Y, X)]).
fromCircList([H1, H2|T] ,[e(H1, H2), e(LAST, H1)|L]) :- last(T, LAST), fromList([H2|T], L).

outDegree([e(X, _)|T], X, OUTPUT) :- outDegree(T, X, PARZIALE), OUTPUT is PARZIALE + 1, !.
outDegree([e(Y, _)|T], X, OUTPUT) :- outDegree(T, X, OUTPUT).
outDegree([e(X, _)], X, 1) :- !.
outDegree([e(X, Y)], Z, 0).

dropNode(G, N, OG) :- dropAll(e(N ,_), G, G2), dropAll(e(_, N) , G2, OG).

reaching([e(X, Y)|T], X, [Y|OUTPUT]) :- reaching(T, X, OUTPUT), !.
reaching([e(A, B)|T], X, OUTPUT) :- reaching(T, X, OUTPUT).
reaching([e(X, Y)], X, [Y]) :- !.
reaching([e(A, B)], X, []).

search(X, [X|_]).
search(X, [_|T]) :- search(X, T).
nodes([e(X, Y)|T], [X, Y|PARZIALE]) :- nodes(T, PARZIALE), not(search(X, PARZIALE)), not(search(Y, PARZIALE)), !.
nodes([e(X, Y)|T], [Y|PARZIALE]) :- nodes(T, PARZIALE), not(search(Y, PARZIALE)), !.
nodes([e(X, Y)|T], [X|PARZIALE]) :- nodes(T, PARZIALE), not(search(X, PARZIALE)), !.
nodes([e(X, Y)|T], PARZIALE) :- nodes(T, PARZIALE).
nodes([e(X, Y)], [X, Y]) :- X \= Y.
nodes([e(X, X)], [X]).

anypath(Graph, Start, Stop, [e(Start, Stop)]) :- search(e(Start, Stop), Graph).
anypath(Graph, Start, Stop, [e(Start, H), OUTPUT]) :- reaching(Graph, Start, [H|T]), anypath(Graph, H, Stop, OUTPUT), !.

allreaching(Graph, StartNode, List) :- findall(X, anypath(Graph, StartNode, X, _), List).

 