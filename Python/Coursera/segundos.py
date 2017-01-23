num = int(input("Por favor, entre com o número de segundos que deseja converter:"))
dia = num // (60*60*24)
num = num % (60*60*24)
horas = num // (60*60)
num = num % (60*60)
minutos = num // 60
segundos = num % 60
print(dia, "dias,", horas, "horas,", minutos, "minutos e", segundos, "segundos.")