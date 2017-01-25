import math
a = float(input("Digite um número para a: "))
b = float(input("Digite um número para b: "))
c = float(input("Digite um número para c: "))
delta = b ** 2 - 4 * a * c
if delta >= 0:
	if delta == 0:
		print("a raiz desta equação é", (-b + math.sqrt(delta)) / 2 * a)
	else:
		print("as raízes da equação são", (-b - math.sqrt(delta)) / 2 * a, "e", (-b + math.sqrt(delta)) / 2 * a)
else:
	print("esta equação não possui raízes reais")