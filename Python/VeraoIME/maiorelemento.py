def maior_elemento(Lista):
	i = 1
	maior = Lista[i-1]
	while i < len(Lista):
		if Lista[i]> maior:
			maior = Lista[i]
		i = i + 1
	return maior
Lista = []
Lista.append(int(input("")))
j = 0
if Lista[j] == 0:
	print("Lista vazia")
else:
	i = 0
	num = int(input(""))
	while num != 0:
		i = i + 1
		Lista.append(num)
		num = int(input(""))
	print(maior_elemento(Lista))