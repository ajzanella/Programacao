
max_largura = int(input('digite a largura: '))
max_altura = int(input('digite a altura: '))
altura = 1
while altura <= max_altura:
	largura = 1
	while largura <= max_largura:
		if altura == 1 or altura == max_altura or largura == 1 or largura == max_largura:
			print('#', end = '')
		else:
			print(' ', end = '')
		largura = largura + 1	
	print()
	altura = altura + 1