
max_largura = int(input('digite a largura: '))
max_altura = int(input('digite a altura: '))
altura = 1
while altura <= max_altura:
	largura = 1
	while largura <= max_largura:
		print('#', end = '')
		largura = largura + 1	
	print()
	altura = altura + 1


