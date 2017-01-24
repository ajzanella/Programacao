def somar_elemento(Lista):
	i = 1
	soma = Lista[i-1]
	while i < len(Lista):
		soma = soma + Lista[i]
		i = i + 1
	return soma
Lista = []
Lista.append(int(input("")))
j = 0
if Lista[j] == 0:
	print(0)
else:
	i = 0
	num = int(input(""))
	while num != 0:
		i = i + 1
		Lista.append(num)
		num = int(input(""))
	print(somar_elemento(Lista))