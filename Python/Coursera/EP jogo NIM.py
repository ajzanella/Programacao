def computador_escolhe_jogada(n, m):
	if n <= m:
		return n
	else:
		aux = estrategia_vencedora(n,m)
		if aux == 0:
			return m
		else:
			return aux


def usuario_escolhe_jogada(n, m):
	pecas = int(input('Quantas peças você vai tirar? '))
	while (pecas <= 0) or (pecas > m) or (pecas > n):
		pecas = int(input('Oops! Jogada inválida! Tente de novo.'))
	return pecas

def  partida():
	n = int(input('Quantas peças? '))
	m = int(input('Limite de peças por jogada? '))
	while n <= m :
		n = int(input('Quantas peças? '))
		m = int(input('Limite de peças por jogada? '))
	turno = quem_comeca(n,m)
	print(turno, 'começa!')
	while n > 0:
		if turno == 'computador':
			turno = 'Você'
			aux = computador_escolhe_jogada(n,m)
			n = n - aux
			vencedor = 'computador'
			print('O computador tirou ',aux, 'peça(s)')
			print('Agora resta(m)', n, 'peças')
		else:
			turno = 'computador'
			aux = usuario_escolhe_jogada(n,m)
			n = n - aux
			vencedor = 'Você'
			print('Você tirou ',aux, 'peça(s)')
			print('Agora resta(m)', n, 'peças')
	if vencedor == 'computador':
		print('Fim de Jogo! O', vencedor, 'ganhou!')
	else:
		print('Fim de Jogo!', vencedor, 'ganhou!')
	return vencedor

def quem_comeca(n,m):
	if n % (m+1) == 0:
		return 'Você'
	else:
		return 'computador'

def estrategia_vencedora(n,m):
	i = 1
	jogada = 0
	while i <= m :
		if (n - i) % (m+1) == 0:
			jogada = i
		i = i + 1
	return jogada

def jogo():
	print('Bem-vindo ao jogo do NIM! Escolha:')
	print('1 - para jogar uma partida isolada')
	print('2 - para jogar um campeonato')
	tipo_jogo = int(input())
	if tipo_jogo == 1:
		partida()
	else:
		campeonato()

def campeonato():
	i = 1
	cont_comp = 0
	cont_voce = 0
	while i <= 3:
		vencedor = partida()
		if vencedor == 'computador':
			cont_comp = cont_comp + 1
		else: 
			cont_voce = cont_comp + 1
		print('Placar: Você ', cont_voce, 'X', cont_comp, 'Computador')
		i=i+1

jogo()
