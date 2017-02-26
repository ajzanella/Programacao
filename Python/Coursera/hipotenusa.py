import math
def soma_hipotenusas(n):
	i = 1
	soma = 0
	while i < n:
		j = i + 1
		while j < n:
			if (math.sqrt(i**2 + j**2) - int(math.sqrt(i**2 + j**2))) == 0:
				soma = soma + math.sqrt((i**2 + j**2))
				j = n
			j = j + 1
		i = i + 1
	return soma