def maior_elemento(lista):
	maior = lista[0]
	i = 1
	while i < len(lista):
		if maior < lista[i]:
			maior = lista[i]
		i = i + 1
	return(maior)
