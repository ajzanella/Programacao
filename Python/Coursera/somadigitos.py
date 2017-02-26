n = int(input('Digite um numero: '))
soma = 0
while n !=0:
	soma = soma + n%10
	n = int(n/10)
print(soma)