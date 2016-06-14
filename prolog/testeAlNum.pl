alphanums(N) :-
    get_char(X),
    trata(X, N).

trata('\n', 0) :- !.
trata(X, N) :-
    is_alnum(X),
    !,
    alphanums(N1),
    N is N1 + 1.
trata(_, N) :-
    alphanums(N).

%% alphanums(N):-
%% 	get_char(X),
%% 	testa(X, N).
%% testa('\n', 0):-!.
%% testa(X, N):-
%% 	is_alnum(X),
%% 	N1 is N-1,
%% 	get_char(Y),
%% 	testa(Y, N1),!.
%% testa(_, N):-
%% 	get_char(Y),
%% 	testa(Y, N).