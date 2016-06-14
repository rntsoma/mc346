myFlatten([], X):-
	X=[].
myFlatten([H|T], X):-
	\+ is_list(H),
	myFlatten(T, Y),
	append([H], Y, X),
	!.
myFlatten([H|T], X):-
	myFlatten(H, Y),
	myFlatten(T, Z),
	append(Y, Z, X).