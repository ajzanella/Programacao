
def fizzbuzz(num):
	if num % 3 != 0 and num % 5 != 0:
		return (num)
	else: 
		aux = ''
		if num % 3 == 0:
			aux = aux + 'Fizz'
		if num % 5 == 0:
			aux = aux + 'Buzz'
		return(aux)
