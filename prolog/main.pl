%% Separa a equacao em lado direito e esquerdo a partir do sinal de igual
trata_lados(Esq=Dir, Resposta):-!,
	instancia(Esq, NumeroEsq, VariavelEsq, 0, SomaVarEsq),
	instancia(Dir, NumeroDir, VariavelDir, 0, SomaVarDir),
	existemVars(SomaVarEsq, SomaVarDir, VariavelEsq, VariavelDir, _),
	Resposta is (NumeroDir - NumeroEsq)/(SomaVarEsq - SomaVarDir).

%% Caso especifico onde a entrada nao possui sinal de igual
trata_lados(_, _):-
	!,
	write('erro; sem sinal de igual: ai nao rola em'),
	fail.

%% Caso especifico onde recebeu-se uma variavel prolog na entrada
instancia(TBD, _, _, _, _):-
	var(TBD),
	!,
	write('erro; variavel prolog como entrada: para de tentar quebrar o programa ae, manolo'),
	fail.

%% Caso 'base' da recursao, verifica se eh um numero
instancia(TBD, Numero, Variavel, _, Sum):-
	number(TBD), !,
	Variavel is 0,
	Sum is 0,
	Numero is TBD.

%% Caso 'base' da recursao, verifica se eh uma variavel
instancia(TBD, Numero, Variavel, _, Sum):-
	atom(TBD), !,
	Numero is 0,
	Sum is 1,
	Variavel = TBD.

%% Caso 'base' da recursao, quando o lado comeca com sinal de -
instancia(-TBD, Numero, Variavel, Acumulador, Sum):-!,
	instancia(TBD, N1, Variavel, Acumulador, S1),
	Numero is -1 * N1,
	Sum is -1 * S1.

%% Caso 'base' da recursao, quando o lado comeca com sinal de +
instancia(+TBD, Numero, Variavel, Acumulador, Sum):-!,
	instancia(TBD, Numero, Variavel, Acumulador, Sum).

%% Caso especifico da 'base' da recursao, verifica se variavel eh negativa
instancia(-TBD, Numero, Variavel, _, Sum):-
	atom(TBD), !,
	Numero is 0,
	Sum is -1,
	Variavel = TBD.

%% Os proximos 4 predicados resolvem os casos em que se tem operacao +, -, * e /
instancia(A+B, Numero, Variavel, Acumulador, SomaVar):-!,
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	SomaVar is Sum1+Sum2,
	Variavel=Var,
	Numero is N1+N2.

instancia(A-B, Numero, Variavel, Acumulador, SomaVar):-!,
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	SomaVar is Sum1-Sum2,
	Variavel=Var,
	Numero is N1-N2.

instancia(A*B, Numero, Variavel, Acumulador, SomaVar):-!,
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	tipoMultiplicacao(Sum1, Sum2, N1, N2, Produto),
	SomaVar=Produto,
	Variavel=Var,
	Numero is N1*N2.

instancia(A/B, Numero, Variavel, Acumulador, SomaVar):-!,
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	tipoDivisao(Sum1, Sum2, N1, N2, Quociente),
	SomaVar=Quociente,
	Variavel=Var,
	Numero is N1/N2.

%% Predicado de falha: se chegou aqui eh pq a entrada estava bem aleatoria
instancia(_, _, _, _, _):-!,
	write('erro; se chegou aqui eh pq o role ta absurdo: vc colocou uma entrada bem louca'),
	fail.

%% Verifica se eh multiplicacao de num x num, num x var ou var x var. Se for var x var, joga excecao
tipoMultiplicacao(Sum1, Sum2, N1, N2, Produto):-
	(Sum1=:=0 -> (Sum2=:=0 -> Produto=0; 
		Produto is N1*Sum2); 
	(Sum2=:=0 -> Produto is N2*Sum1; 
		(!,write('erro; equacao de grau diferente de 1: esse solver resolve para 1, cara'),
			fail))).

%% Os 3 proximos predicados verificam se ocorre divisao por zero ou se a variavel esta no divisor
%% Se a variavel aparecer no divisor joga uma excecao, pois a equacao teria um ponto nao definido
%% ex: x/x-> indefinido para x=0

%% Variavel dividido por numero
tipoDivisao(Sum1, _, _, N2, Quociente):-
	(N2=\=0 -> Quociente is Sum1/N2; (!, write('erro; divisao por zero ou por variavel: absurdo! IMECC vai surtar!'), fail)).

%% Numero dividido por variavel
tipoDivisao(_, Sum2, N1, _, Quociente):-
	(Sum2=\=0 ->Quociente is N1/Sum2; (!, write('erro; divisao por zero: absurdo! IMECC vai te pegar!'), fail)).

%% Variavel dividido por variavel
tipoDivisao(Sum1, Sum2, _, _, Quociente):-
	(Sum2=\=0 ->Quociente is Sum1/Sum2; (!, write('erro; divisao por variavel,
		equacao nao vale para todo o conjunto dos reais: o cara insiste em querer quebrar meu codigo!'), fail)).

%% Os 4 proximos predicados retornam as variaveis encontradas a cada nivel da recursao
%% Caso sejam encontradas variaveis distintas, joga-se excecao

%% Verifica se o termo da esquerda e variavel
verificaVars(0, Var2, Variavel):-
	atom(Var2), !,
	Variavel=Var2.

%% Verifica se o termo da direita e variavel
verificaVars(Var1, 0, Variavel):-
	atom(Var1), !,
	Variavel=Var1.

%% Verifica se os dois termos sao variaveis. Se forem distintas, joga excecao
verificaVars(Var1, Var2, Variavel):-
	atom(Var1), !,
	(Var1==Var2 -> Variavel=Var1;
		(!, write('erro; mais de uma variavel na equacao: pare de ser zoeiro, cara'), fail)).

%% Caso especifico onde nenhum deles e variavel, temos dois numeros no lugar dos termos
verificaVars(0, 0, _).

%% Os 3 proximos predicados verificam se existem variaveis nos lados da equacao, jogando excecao se as variaveis
%% dos lados divergirem
existemVars(0, 0, _, _, _):-
	!,
	write('erro; sem variaveis na equacao: coloca uma variavel ae! So nao poe com letra maiuscula'),
	fail.

existemVars(SomaVarEsq, SomaVarDir, VariavelEsq, VariavelDir, _):-
	verificaVars(VariavelEsq, VariavelDir, _),
	SomaVarEsq=:=SomaVarDir,
	!,
	write('erro; sem variaveis na equacao: coloca uma variavel ae! So nao poe com letra maiuscula'),
	fail.

existemVars(_, _, VariavelEsq, VariavelDir, VarFinal):-
	verificaVars(VariavelDir, VariavelEsq, VarFinal).

main:- 
	catch(read(X), _, format('erro; erro de sintaxe: escreve certo ae~n')),
    \+var(X),
    trata_lados(X, Resposta),
    write(Resposta),
    write('; ok'), nl.