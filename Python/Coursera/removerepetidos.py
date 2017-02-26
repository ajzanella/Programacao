def remove_repetidos(lista):
	i = 0
	while i < len(lista):
		j = len(lista)-1
		while j > i:
			if lista[i] == lista[j]:
				del lista[j]
			j = j - 1
		i = i + 1
	lista.sort()
	return(lista)