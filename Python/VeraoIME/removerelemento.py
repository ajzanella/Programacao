def remover_elemento(Lista):
	j = len(Lista)
	while j > 0:
		i = 0
		while i < j - 1:
			if Lista[j-1] == Lista[i]:
				del Lista[j-1]
				i = j + 1
			i = i + 1
		j = j - 1
	return Lista
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
	print(remover_elemento(Lista))