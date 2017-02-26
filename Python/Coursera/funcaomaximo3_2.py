def maior(num1, num2):
	if num1 <= num2:
		return num2
	else:
		return num1
def maximo(num1, num2, num3):
	return(maior(maior(num1,num2),num3))