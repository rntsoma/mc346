class MyError(Exception):
	def __init__(self, error):
		self.str=error

	def __str__(self):
		return self.str