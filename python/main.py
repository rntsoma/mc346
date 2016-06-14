import sys
from myError import MyError
from bisect import bisect_left, insort_left

def binarySearch(vect, x):
    i = bisect_left(vect, x)
    if i != len(vect) and vect[i] == x:
        return i
    return -1

def getFirstCoordinate(item):
    return item[1]

def checkID(lista, value):
    if(binarySearch(lista, value) == -1):
        if(lista==[]):
            lista.append(value)
        else:
            insort_left(lista, value)
    else:
        raise MyError("Elementos com ID's repetidos")
    return lista

def treatInput():
    arr = []
    arrID = []
    for line in sys.stdin.readlines():
        try:
            temp = map(int, line.split())
            if(len(temp) == 3):
                arr.append(temp)
                arrID = checkID(arrID, temp[0])
            else:
                raise MyError("Numero invalido de argumentos")
        except ValueError:
            print "Entrada invalida, possiveis caracteres na entrada"
            raise SystemExit
        except MyError as err:
            print err.str
            raise SystemExit
    # Sort array based on first coordinate
    arr=sorted(arr, key=getFirstCoordinate)
    return arr

def findElo(arr):
    pass

def main():
    arr=treatInput()
    elo=findElo(arr)
    print elo

main()