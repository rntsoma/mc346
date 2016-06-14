junta([], SeqAtual, SeqTotal, _, Resposta):-
	append(SeqTotal, [SeqAtual], SeqTotal),
	Resposta=SeqTotal.
junta([H|T], SeqAtual, SeqTotal, UltimoChar, Resposta):-
	H==UltimoChar,
	append(SeqAtual, [H], SeqAtual),
	junta(T, SeqAtual, SeqTotal, H, X1),
	Resposta=X1.
junta([H|T], SeqAtual, SeqTotal, UltimoChar, Resposta):-
	H\==UltimoChar,
	append(SeqTotal, [SeqAtual], SeqTotal),
	junta(T, [], SeqTotal, H, X1),
	Resposta=X1.
pack(Lista, X):-
	junta(Lista, [], [], _, X).