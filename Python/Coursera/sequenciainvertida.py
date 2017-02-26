n = int(input('Digite um numero: '))
lista = []
while n != 0:
	lista.append(n) 
	n = int(input('Digite um numero: '))
i = len(lista)
while i >= 1 :
	print(lista[i-1])
	i = i - 1