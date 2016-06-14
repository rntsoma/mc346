seek(X, [H|_], SeekedPosition, CurrentPosition):-
	SeekedPosition =:= CurrentPosition,
	X=H.
seek(X, [_|T], SeekedPosition, CurrentPosition):-
	Temp is CurrentPosition + 1,
	seek(X, T, SeekedPosition, Temp).
element_at(X, List, SeekedPosition):-
	seek(X, List, SeekedPosition, 1),
	!.