class Elemento:
	def __init__(self, id, xmin, xmax):
		self.id=id
		self.xmin=xmin
		self.xmax=xmax

	def getId(self):
		return self.id

	def getXmin(self):
		return self.xmin

	def getXmax(self):
		return self.xmax