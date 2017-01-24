def inverter_lista(Lista):
	i = 0
	Lista2 = []
	j = len(Lista)-1
	while i < len(Lista):
		Lista2.append(Lista[j])
		i = i + 1
		j = j - 1
	return Lista2
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
	print(inverter_lista(Lista))