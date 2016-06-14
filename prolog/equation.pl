%% Separa a equacao em lado direito e esquerdo a partir
%% do sinal de igual
trata_lados(Esq=Dir, Resposta):-
	instancia(Esq, NumeroEsq, VariavelEsq, 0, SomaVarEsq),
	instancia(Dir, NumeroDir, VariavelDir, 0, SomaVarDir),
	existemVars(SomaVarEsq, SomaVarDir, VariavelEsq, VariavelDir, _),
	Resposta is (NumeroDir - NumeroEsq)/(SomaVarEsq - SomaVarDir).

%% Caso especifico onde a entrada nao possui sinal de igual
trata_lados(_, _):-
	throw('sem sinal de igual').

%% Caso especifico onde recebeu-se uma variavel prolog na entrada
instancia(TBD, _, _, _, _):-
	var(TBD),
	throw('variavel prolog como entrada').

%% Caso 'base' da recursao, verifica se e um numero
instancia(TBD, Numero, Variavel, _, Sum):-
	number(TBD), !,
	Variavel is 0,
	Sum is 0,
	Numero is TBD.

%% Caso 'base' da recursao, verifica se e uma variavel
instancia(TBD, Numero, Variavel, _, Sum):-
	atom(TBD), !,
	Numero is 0,
	Sum is 1,
	Variavel = TBD.

%% Caso especifico da base, verifica se variavel e negativa
instancia(-TBD, Numero, Variavel, _, Sum):-
	atom(TBD), !,
	Numero is 0,
	Sum is -1,
	Variavel = TBD.

%% Trata o caso em que temos uma soma nos termos
instancia(A+B, Numero, Variavel, Acumulador, SomaVar):-
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	SomaVar is Sum1+Sum2,
	Variavel=Var,
	Numero is N1+N2.

%% Trata o caso em que temos uma subtracao nos termos
instancia(A-B, Numero, Variavel, Acumulador, SomaVar):-
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	SomaVar is Sum1-Sum2,
	Variavel=Var,
	Numero is N1-N2.

%% Trata o caso em que temos uma multiplicacao nos termos
instancia(A*B, Numero, Variavel, Acumulador, SomaVar):-
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	tipoMultiplicacao(Sum1, Sum2, N1, N2, Produto),
	SomaVar=Produto,
	Variavel=Var,
	Numero is N1*N2.

%% Trata o caso em que temos uma divisao nos termos
instancia(A/B, Numero, Variavel, Acumulador, SomaVar):-
	instancia(A, N1, V1, Acumulador, Sum1),
	instancia(B, N2, V2, Acumulador, Sum2),
	verificaVars(V1, V2, Var),
	tipoDivisao(Sum1, Sum2, N1, N2, Quociente),
	SomaVar=Quociente,
	Variavel=Var,
	Numero is N1/N2.

%% Verifica se e multiplicacao de num x num, num x var
 %% ou var x var. Se for var x var, joga excecao
tipoMultiplicacao(Sum1, Sum2, N1, N2, Produto):-
	(Sum1=:=0 -> (Sum2=:=0 -> Produto=0; 
		Produto is N1*Sum2); 
	(Sum2=:=0 -> Produto is N2*Sum1; 
		throw('equacao de grau diferente de 1'))).

%% Verifica se ocorre divisao por zero ou se a variavel esta
%% no divisor. Se a variavel aparecer no divisor, joga uma 
%% excecao, pois a equacao teria um ponto nao definido
%% ex: x/x-> indefinido para x=0
tipoDivisao(Sum1, _, _, N2, Quociente):-
%% Variavel dividido por numero
	(N2=\=0 -> Quociente is Sum1/N2; throw('divisao por zero ou por variavel')).

%% Numero dividido por variavel
tipoDivisao(_, Sum2, N1, _, Quociente):-
	(Sum2=\=0 ->Quociente is N1/Sum2; 'divisao por zero').

%% Variavel dividido por variavel
tipoDivisao(Sum1, Sum2, _, _, Quociente):-
	(Sum2=\=0 ->Quociente is Sum1/Sum2; 'divisao por variavel:
		equacao nao vale para todo o conjunto dos reais').

%% Verifica se o termo da esquerda e variavel, caso positivo,
%% o retorna
verificaVars(0, Var2, Variavel):-
	atom(Var2), !,
	Variavel=Var2.

%% Verifica se o termo da direita e variavel, caso positivo,
%% o retorna
verificaVars(Var1, 0, Variavel):-
	atom(Var1), !,
	Variavel=Var1.

%% Verifica se os dois termos sao variaveis. Se forem distintas,
%% joga excecao
verificaVars(Var1, Var2, Variavel):-
	atom(Var1), !,
	(Var1==Var2 -> Variavel=Var1; 
		throw('mais de uma variavel na equacao')).

%% Caso especifico onde nenhum deles e variavel, e temos
%% dois numeros no lugar dos termos
verificaVars(0, 0, _).

%% Verifica se existem variaveis nos lados, e se elas sao iguais
existemVars(0, 0, _, _, _):-
	throw('sem variaveis na equacao').

existemVars(SomaVarEsq, SomaVarDir, VariavelEsq, VariavelDir, _):-
	verificaVars(VariavelEsq, VariavelDir, _),
	SomaVarEsq=:=SomaVarDir,	
	throw('sem variaveis na equacao').

existemVars(_, _, VariavelEsq, VariavelDir, VarFinal):-
	verificaVars(VariavelDir, VariavelEsq, VarFinal).

main:- 
	catch(read(X), _, format('erro: syntax error~n')),
    \+var(X),
    catch(trata_lados(X, Resposta), E, format('error: ~w~n', E)),
    \+var(Resposta),
    write(Resposta),
    write('; ok'), nl.