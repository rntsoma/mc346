conta_linha(N) :- conta_aux(0, N).
conta_aux(A, N) :- get_char('\n'), !, N = A.
conta_aux(A, N) :- A1 is A + 1, conta_aux(A1, N).