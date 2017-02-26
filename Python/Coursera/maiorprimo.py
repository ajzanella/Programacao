import math
def maior_primo(num):
	n = num
	primo = 'false'
	while n >= 1 and primo == 'false':
		primo = fun_primo(n)
		n = n - 1
	return(n+1)

def fun_primo (n):
	i = 2
	primo = 'true'
	while i <= math.sqrt(n) and primo == 'true':
		if n % i == 0:
			primo = 'false'
		i = i + 1
	return primo
