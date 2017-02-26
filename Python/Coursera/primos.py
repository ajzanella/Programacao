import math
def n_primos(n):
	cont = 0
	i = 2
	while i <= n:
		if ehprimo(i) =='true':
			cont = cont + 1
		i = i + 1
	return cont

def ehprimo (n):
	i = 2
	primo = 'true'
	while i <= math.sqrt(n) and primo == 'true':
		if n % i == 0:
			primo = 'false'
		i = i + 1
	return primo
