cadeia(L, [X,Y]) :-
    member(pre(X, Y), L).
cadeia(L, [X, Y|Z]) :-
    member(pre(X, Y), L),
    cadeia(L, [Y|Z]).