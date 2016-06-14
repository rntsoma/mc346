import sys
from myError import MyError
from bisect import bisect_left, insort_left

# Funcao que realiza a busca binaria, recebe o valor e ve se ele esta no vetor
# tentarei adicionar a complexidade das funcoes apenas para treinar
# Complexidade: O(lgn)
def binarySearch(vect, x):
    i = bisect_left(vect, x)
    if i != len(vect) and vect[i] == x:
        return i
    return -1

# Recebe um elemento (vetor) e Retorna a primeira coordenada do elemento,
# no formato [a,b,c]. Ou seja, retorna b
# Complexidade: O(1)
def getFirstCoordinate(item):
    return item[1]

# Recebe um vetor de id e o id do elemento atual.
# Verifica se o id do elemento já está na lista. Se estiver lanca excecao
# Se nao estiver, adiciona o id no local correto, de forma a deixar o vetor
# ordenado ao retornar.
# Complexidade: O(n) -> insercao domina em relacao a busca
def checkID(lista, value):
    if(binarySearch(lista, value) == -1):
        if(lista==[]):
            lista.append(value)
        else:
            insort_left(lista, value)
    else:
        raise MyError("erro; Elementos com ID's repetidos")
    return lista

# Le a entrada e realiza o tratamento. Lanca excecoes caso as entradas
# estejam fora do que deveriam.
# Complexidade: O(n^2) -> devido ao fato de chamar checkID a cada elemento de entrada
def treatInput():
    arr = []
    arrID = []
    for line in sys.stdin.readlines():
        try:
            temp = map(int, line.split())
            if(len(temp) == 3):
                if(temp[2]<temp[1]):
                    raise MyError("erro; segunda coordenada menor que a primeira")
                arr.append(temp)
                arrID = checkID(arrID, temp[0])
            else:
                raise MyError("erro; Numero invalido de argumentos")
        except ValueError:
            print "erro; Entrada invalida, possiveis caracteres na entrada"
            raise SystemExit
        except MyError as err:
            print err.str
            raise SystemExit
    try:
        if len(arr)<=1:
            raise MyError("erro; Colecao pequena demais")
    except MyError as err:
        print err.str
        raise SystemExit
    # Sort array based on first coordinate
    arr=sorted(arr, key=getFirstCoordinate)
    return arr

# Recebe o vetor de elementos da entrada e acha o elo
# Complexidade: O(n)
def findElo(arr, anterior):
    minNum=anterior[1]
    maxNum=anterior[2]
    potElo=sys.maxint
    for x in arr:
        if(x[1] >= minNum and x[2] <= maxNum):
            temp=x[2]-x[1]
            if(temp < potElo):
                potElo=temp
        else:
            temp=anterior[2]-x[1]
            if(abs(temp) < potElo):
                potElo=temp
            if(x[1]<minNum):
                minNum=x[1]
            if(x[2]>maxNum):
                maxNum=x[2]
            anterior=x
    return potElo

# Funcao principal
def main():
    arr=treatInput()
    head = arr.pop(0)
    print findElo(arr, head)

main()