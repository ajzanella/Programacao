import math
x1 = int(input("Digite um numero inteiro x1: "))
y1 = int(input("Digite um numero inteiro y1: "))
x2 = int(input("Digite um numero inteiro x2: "))
y2 = int(input("Digite um numero inteiro y2: "))
distancia = math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
if distancia >= 10:
	print("longe")
else:
	print("perto")
