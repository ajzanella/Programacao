n = int(input('Digite um numero: '))
a = 'Não'
num1 = n % 10
n = int(n / 10)
while n !=0:
	num2 = n % 10
	if num1 == num2:
		a = 'Sim'
		n = 0
	num1 = num2
	n = int(n / 10)
print(a)