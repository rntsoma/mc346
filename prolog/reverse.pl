reverse([A], B):-
	B=[A],
	!.
reverse([H|T], B):-
	reverse(T, C),
	append(C, [H], B).