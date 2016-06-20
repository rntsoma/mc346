# Questao 1

def reps(lista):
	final=[]
	lista.sort()
	if(lista==[]):
		return final
	else:
		anterior=lista.pop(0)
		while lista != []:
			if anterior in lista:
				if not(anterior in final):
					final.append(anterior)
			anterior=lista.pop(0)
	return final

# print reps([1,4,2,3,4,2,3,4])

# Questao 2

def brancos(str):
	try:
		file = open(str, "r")
		counter=0
		for line in file:
			counter += line.count(' ')
		file.close()
	# Falha ao abrir
	except IOError:
		print "falha ao abrir"
		if(not file.closed()):
			file.close()
	# Falha ao ler
	except:
		print "falha ao ler"
		if(not file.closed()):
			file.close()
	return counter

# Questao 3

def inva(d):
	keys=[]
	values=[]
	for x in d.keys():
		keys.append(x)
	for x in d.values():
		values.append(x)
	i=0
	newDict={}
	while i<len(values):
		if values[i] in newDict.keys():
			newDict[values[i]].append(keys[i])
		else:
			newDict[values[i]]=[keys[i]]
		i+=1
	return newDict

# print inva({1:2, 3:1, 4:2})
# print inva({})
# print inva({2:1, 1:2})

# Questao 4

class Intervalo:
	def __init__(self, id, xmin, xmax):
		if(type(id) is int and type(xmin) is int and type(xmax) is int):
			self.id=id
			self.xmin=xmin
			self.xmax=xmax
		else:
			# Interessante seria criar um erro proprio, mas usarei este
			raise RuntimeError

	def elo(self, intervalo):
		# Abrange os dois casos pedidos
		return self.xmax - intervalo.xmin

# a=Intervalo(id=1, xmin=2, xmax=3)
# b=Intervalo(id=2, xmin=3, xmax=4)
# print a.elo(b)
# print b.elo(Intervalo(id=4, xmin=8, xmax=15))
# print a.elo(Intervalo(id=8, xmin=2, xmax=4))