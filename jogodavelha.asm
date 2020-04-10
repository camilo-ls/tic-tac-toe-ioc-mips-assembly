# TRABALHO DE INTRODUÇÃO À ORGANIZAÇÃO DE COMPUTADORES
# JOGO DA VELHA
# Aluno: Camilo Lira Sidou

.data
# MENSAGENS:
	msg_jogada: .asciiz "Digite uma posição: [1-9], conforme o keypad númerico:"
	msg_invalida: .asciiz "ERRO: posição inválida. "
	msg_jogador1: .asciiz "Jogador 1, é a sua vez:\n"
	msg_jogador2: .asciiz "Jogador 2, é a sua vez:\n"
	msg_fim_velha: .asciiz "Deu velha!\n"
	msg_fim_jog1: .asciiz "Jogador 1 venceu!"
	msg_fim_jog2: .ascii"Jogador 2 venceu!"
	separador: .asciiz "-----"
	nova_linha: .asciiz "\n"
	
# CONDIÇÕES DE EXECUÇÃO/FINALIZAÇÃO DO JOGO:
	jogo: .word 1
	vencedor: .word 0

# TABULEIRO:
	lin1: .word 0, 0, 2 # init da lin1 idx: 7 8 9
	lin2: .word 0, 0, 0 # init da lin2 idx: 4 5 6
	lin3: .word 2, 0, 0 # init da lin3 idx: 1 2 3

.macro print_lin1()
	la $s0, lin1 # carrega o endereço do tab. no reg. $s0
	li $t0, 0 # t0 será a var. contadora
	li $t1, 2 # t1 será o critério de parada
	loop_lin1:
	bgt $t0, $t1, loop_lin1_end # if (t0 > t1) break;
		lw $a0, ($s0) # carrega o valor 
		beq $a0, 0, print_vazio # se a0 == 0, então devemos pular pra label print_vazio
		j print_vazio_end # senão, pula o bloco de código, indo para print_vazio_end
		print_vazio:
			li, $a0, ' '
			li $v0, 11	
		print_vazio_end:
		beq $a0, 1, print_x # se a0 == 1, então devemos pular pro label print_x
		j print_x_end # senão, pula pro label print_x_end
		print_x:
			li, $a0, 'X'
			li $v0, 11
		print_x_end:
		beq $a0, 2, print_o # se a0 == 2, então devemos pular pro label print_o
		j print_o_end
		print_o:
			li $a0, 'O'
			li $v0, 11
		print_o_end:
		syscall # imprime o valor em $a0 ($s0)
		addi $s0, $s0, 4 # move o end. em $s0 4 bytes >>
		beq $t0, 2, jump_sep_end # if (t0 == 2) goto: jump_sep_end
			li $v0, 11 # carrega 11 na var. de tipo de saída ($v0)
			li $a0, '|' # carrega o separador da var. de conteúdo de saída ($a0)
			syscall # imprime o separador '|'
		jump_sep_end:
		addi $t0, $t0, 1 # inc. a variável t0
		j loop_lin1	
	loop_lin1_end:
.end_macro

.macro print_lin2()
	la $s0, lin2 # carrega o endereço do tab. no reg. $s0
	li $t0, 0 # t0 será a var. contadora
	li $t1, 2 # t1 será o critério de parada
	loop_lin1:
	bgt $t0, $t1, loop_lin1_end # if (t0 > t1) break;
		lw $a0, ($s0) # carrega o valor 
		beq $a0, 0, print_vazio # se a0 == 0, então devemos pular pra label print_vazio
		j print_vazio_end # senão, pula o bloco de código, indo para print_vazio_end
		print_vazio:
			li, $a0, ' '
			li $v0, 11	
		print_vazio_end:
		beq $a0, 1, print_x # se a0 == 1, então devemos pular pro label print_x
		j print_x_end # senão, pula pro label print_x_end
		print_x:
			li, $a0, 'X'
			li $v0, 11
		print_x_end:
		beq $a0, 2, print_o # se a0 == 2, então devemos pular pro label print_o
		j print_o_end
		print_o:
			li $a0, 'O'
			li $v0, 11
		print_o_end:
		syscall # imprime o valor em $a0 ($s0)
		addi $s0, $s0, 4 # move o end. em $s0 4 bytes >>
		beq $t0, 2, jump_sep_end # if (t0 == 2) goto: jump_sep_end
			li $v0, 11 # carrega 11 na var. de tipo de saída ($v0)
			li $a0, '|' # carrega o separador da var. de conteúdo de saída ($a0)
			syscall # imprime o separador '|'
		jump_sep_end:
		addi $t0, $t0, 1 # inc. a variável t0
		j loop_lin1	
	loop_lin1_end:
.end_macro

.macro print_lin3()
	la $s0, lin3 # carrega o endereço do tab. no reg. $s0
	li $t0, 0 # t0 será a var. contadora
	li $t1, 2 # t1 será o critério de parada
	loop_lin1:
	bgt $t0, $t1, loop_lin1_end # if (t0 > t1) break;
		lw $a0, ($s0) # carrega o valor 
		beq $a0, 0, print_vazio # se a0 == 0, então devemos pular pra label print_vazio
		j print_vazio_end # senão, pula o bloco de código, indo para print_vazio_end
		print_vazio:
			li, $a0, ' '
			li $v0, 11	
		print_vazio_end:
		beq $a0, 1, print_x # se a0 == 1, então devemos pular pro label print_x
		j print_x_end # senão, pula pro label print_x_end
		print_x:
			li, $a0, 'X'
			li $v0, 11
		print_x_end:
		beq $a0, 2, print_o # se a0 == 2, então devemos pular pro label print_o
		j print_o_end
		print_o:
			li $a0, 'O'
			li $v0, 11
		print_o_end:
		syscall # imprime o valor em $a0 ($s0)
		addi $s0, $s0, 4 # move o end. em $s0 4 bytes >>
		beq $t0, 2, jump_sep_end # if (t0 == 2) goto: jump_sep_end
			li $v0, 11 # carrega 11 na var. de tipo de saída ($v0)
			li $a0, '|' # carrega o separador da var. de conteúdo de saída ($a0)
			syscall # imprime o separador '|'
		jump_sep_end:
		addi $t0, $t0, 1 # inc. a variável t0
		j loop_lin1	
	loop_lin1_end:
.end_macro

# imprime o separador "-----":
.macro print_sep()
	la $a0, separador
	li $v0, 4
	syscall
.end_macro

# faz a quebra de linha ou imprime uma linha vazia:
.macro nova_lin()
	la $a0, nova_linha
	li $v0, 4
	syscall
.end_macro

# imprime o tabuleiro:
.macro print_tab()
	nova_lin()
	print_lin1()
	nova_lin()
	print_sep()
	nova_lin()
	print_lin2()
	nova_lin()
	print_sep()
	nova_lin()
	print_lin3()
	nova_lin()
	nova_lin()
.end_macro

# checa se o jogo terminou em velha:
.macro check_draw()
# carrega as linhas nos registradores s:
	la $s0, lin1
	la $s1, lin2
	la $s2, lin3
# carrega as posicoes nos registradores t:
	lw $t0, ($s0) # pos 7
	beq $t0, 0, fim_check
	lw $t0, 4($s0) # pos 8
	beq $t0, 0, fim_check
	lw $t0, 8($s0) # pos 9
	beq $t0, 0, fim_check
	lw $t0, ($s1) # pos 4
	beq $t0, 0, fim_check
	lw $t0, 4($s1) # pos 5
	beq $t0, 0, fim_check
	lw $t0, 8($s1) # pos 6
	beq $t0, 0, fim_check
	lw $t0, ($s2) # pos 1
	beq $t0, 0, fim_check
	lw $t0, 4($s2) # pos 2
	beq $t0, 0, fim_check
	lw $t0, 8($s2) # pos 3
	beq $t0, 0, fim_check
# se chegou aqui, todas as pos. do tab. estão preenchidas com valores e não houve um vencedor. jogo finaliza:
	li $t0, 0
	sw $t0, jogo
# finaliza a macro:
	fim_check:
.end_macro

# checa se o jogo terminou com um vencedor:
.macro check_end()
	la $s0, lin1 # carrega o end. da linha 1 em $s0
	la $s1, lin2 # carrega o end. da linha 2 em $s1
	la $s2, lin3 # carrega o end. da linha 3 em $s2
# VERIFICAÇÃO DAS LINHAS:
# primeira linha:
	lw $t0, ($s0) # pos 7
	lw $t1, 4($s0) # pos 8
	lw $t2, 8($s0) # pos 9
	bne $t0, $t1, lin_2
	jal checar_terceiro

lin_2:
# segunda linha:
	lw $t0, ($s1) # pos 4
	lw $t1, 4($s1) # pos 5
	lw $t2, 8($s1) # pos 6
	bne $t0, $t1, lin_3
	jal checar_terceiro

lin_3:
# terceira linha:
	lw $t0, ($s2) # pos 1
	lw $t1, 4($s2) # pos 2
	lw $t2, 8($s2) # pos 3
	bne $t0, $t1, col_1
	jal checar_terceiro
	
# VERIFICAÇÃO DAS COLUNAS:
col_1:
# primeira coluna:
	lw $t0, ($s0) # pos 7
	lw $t1, ($s1) # pos 4
	lw $t2, ($s2) # pos 1
	bne $t0, $t1, col_2
	jal checar_terceiro

col_2:
# segunda coluna:
	lw $t0, 4($s0) # pos 8
	lw $t1, 4($s1) # pos 5
	lw $t2, 4($s2) # pos 2
	bne $t0, $t1, col_3
	jal checar_terceiro

col_3:	
# terceira coluna:
	lw $t0, 8($s0) # pos 9
	lw $t1, 8($s1) # pos 6
	lw $t2, 8($s2) # pos 3
	bne $t0, $t1, diag_1
	jal checar_terceiro
	
# VERIFICAÇÃO DAS DIAGONAIS:
diag_1:
# diagonal principal:
	lw $t0, ($s0) # pos 7
	lw $t1, 4($s1) # pos 5
	lw $t2, 8($s2) # pos 3
	bne $t0, $t1, diag_2
	jal checar_terceiro

diag_2:
# diagonal secundária:
	lw $t0, 8($s0) # pos 9
	lw $t1, 4($s1) # pos 5
	lw $t2 ($s2) # pos 1
	bne $t0, $t1, fim_check
	jal checar_terceiro
	j fim_check
	
# checa se t1 = t2:
checar_terceiro:
	bne $t1, $t2, check_fail
	beq $t0, 0, fim_check
	beq $t1, 0, fim_check
	beq $t2, 0, fim_check
	j fim_jogo
check_fail:
	jr $ra
# o jogo acabou. faz a verificação de quem ganhou:
fim_jogo:
# determina quem ganhou o jogo a partir de $t2. se $t2 = 1, então ganhou o jogador 1.
# se $t2 = 2, então ganhou o jogador 2. no caso de $t0 = 0, o jogo deu velha.
	beq $t0, 1, fim_jogo_ganhador_1
	beq $t0, 2, fim_jogo_ganhador_2
	j fim_jogo_finalizar
# jogador 1 venceu:
fim_jogo_ganhador_1:
	li $t0, 1
	sw $t0, vencedor
	j fim_jogo_finalizar
# jogador 2 venceu:
fim_jogo_ganhador_2:
	li $t0, 2
	sw $t0, vencedor
# >> termina o jogo (var. jogo = 0)
fim_jogo_finalizar:
	li $t1, 0
	sw $t1, jogo
fim_check:
.end_macro

.macro play(%pow, %player)
inicio_jogada:
	beq %pow, 1, play_1
	beq %pow, 2, play_2
	beq %pow, 3, play_3
	beq %pow, 4, play_4
	beq %pow, 5, play_5
	beq %pow, 6, play_6
	beq %pow, 7, play_7
	beq %pow, 8, play_8
	beq %pow, 9, play_9
	j fim_jogada
play_1:
	li $t2, %player
	la $s0, lin3
	sw $t2, ($s0)
	j fim_jogada
play_2:
	li $t2, %player
	la $s0, lin3
	sw $t2, 4($s0)
	j fim_jogada
play_3:
	li $t2, %player
	la $s0, lin3
	sw $t2, 8($s0)
	j fim_jogada
play_4:
	li $t2, %player
	la $s0, lin2
	sw $t2, ($s0)
	j fim_jogada
play_5:
	li $t2, %player
	la $s0, lin2
	sw $t2, 4($s0)
	j fim_jogada
play_6:
	li $t2, %player
	la $s0, lin2
	sw $t2, 8($s0)
	j fim_jogada
play_7:
	li $t2, %player
	la $s0, lin1
	sw $t2, ($s0)
	j fim_jogada
play_8:
	li $t2, %player
	la $s0, lin1
	sw $t2, 4($s0)
	j fim_jogada
play_9:
	li $t2, %player
	la $s0, lin1
	sw $t2, 8($s0)
	j fim_jogada
fim_jogada:
.end_macro

.macro jogada_p1()
inicio_jogada:
	la $a0, msg_jogador1 # carrega a mensagem de turno do jogador 1
	li $v0, 4 # instrução para imprimir string
	syscall # imprime a instrução
	la $a0, msg_jogada # carrega a mensagem para o jogador fazer a sua jogada
	syscall # imprime a mensagem
	li $v0, 5 # instrução para a leitura do input do jogador
	syscall # executa a leitura
	move $t0, $v0 # move o valor passado pelo player para $t0
	blt $t0, 1, jogada_invalida
	bgt $t0, 9, jogada_invalida
# verifica qual a linha da jogada e pula pra flag correspondente:
	ble $t0, 3, ver_lin3
	ble $t0, 6, ver_lin2
	ble $t0, 9, ver_lin1
# faz a verificação se a pos. escolhida na linha 3 já foi ocupada:
ver_lin3:
	move $t1, $t0
	subi $t1, $t1, 1
	mul $t1, $t1, 4
	lw $t2, lin3($t1)
	bne $t2, 0, jogada_invalida
	j _play
# faz a verificação se a pos. escolhida na linha 2 já foi ocupada:
ver_lin2:
	move $t1, $t0
	subi $t1, $t1, 4
	mul $t1, $t1, 4
	lw $t2, lin2($t1)
	bne $t2, 0, jogada_invalida
	j _play
# faz a verificação se a pos. escolhida na linha 1 já foi ocupada:
ver_lin1:
	move $t1, $t0
	subi $t1, $t1, 7
	mul $t1, $t1, 4
	lw $t2, lin1($t1)
	bne $t2, 0, jogada_invalida
# faz a jogada no tabuleiro:
_play:
	play($t0, 1)
	j fim_jogada
# caso a pos. seja invalidada em alguma das condicoes acima, pula pra cá:
jogada_invalida:
	la $a0, msg_invalida
	li $v0, 4
	syscall
	j inicio_jogada
fim_jogada:
.end_macro

.macro jogada_p2()
inicio_jogada:
	la $a0, msg_jogador2 # carrega a mensagem de turno do jogador 2
	li $v0, 4 # instrução para imprimir string
	syscall # imprime a instrução
	la $a0, msg_jogada # carrega a mensagem para o jogador fazer a sua jogada
	syscall # imprime a mensagem
	li $v0, 5 # instrução para a leitura do input do jogador
	syscall # executa a leitura
	move $t0, $v0 # move o valor passado pelo player para $t0
	# verifica se a pos. indicada é > 9 ou < 1
	blt $t0, 1, jogada_invalida
	bgt $t0, 9, jogada_invalida
	# verificação se a pos. foi ocupada:
	ble $t0, 3, ver_lin3
	ble $t0, 6, ver_lin2
	ble $t0, 9, ver_lin1
	j _play
ver_lin3:
	move $t1, $t0
	subi $t1, $t1, 1
	mul $t1, $t1, 4
	lw $t2, lin3($t1)
	bne $t2, 0, jogada_invalida
	j _play
ver_lin2:
	move $t1, $t0
	subi $t1, $t1, 4
	mul $t1, $t1, 4
	lw $t2, lin2($t1)
	bne $t2, 0, jogada_invalida
	j _play
ver_lin1:
	move $t1, $t0
	subi $t1, $t1, 7
	mul $t1, $t1, 4
	lw $t2, lin1($t1)
	bne $t2, 0, jogada_invalida
	j _play
_play:
	play($t0, 2)
	j fim_jogada
	jogada_invalida:
	la $a0, msg_invalida
	li $v0, 4
	syscall
	j inicio_jogada
fim_jogada:
.end_macro

.text
começo:
# jogada do player 1:
	print_tab() # imprime o tabuleiro:
	jogada_p1() # p1 faz a sua jogada:
	check_end() # checa se a jogada de p1 resulta no fim do jogo com um vencedor:
	check_draw() # se não houve vencedor, checa se o tabuleiro foi preenchido (velhou)
# checa pra ver se o jogo finalizou:
	lw $t5, jogo # carrega o valor de 'jogo' (1 = rodando / 0 = finalizado)
	beq $t5, 0, fim_jogo # se jogo = 0, pula pra fim_jogo
# jogada do player 2:
	print_tab() # imprime novamente o tabuleiro:
	jogada_p2() # p2 faz a sua jogada:
	check_end() # checa novamente se a jogada resultou no fim do jogo com um vencedor:
	check_draw() # checa novamente se o tabuleiro foi preenchido (velhou):
# checa novamente para ver se o jogo finalizou:
	lw $t5, jogo # carrega o valor de 'jogo' (1 = rodando / 0 = finalizado)
	beq $t5, 0, fim_jogo # se jogo = 0, pula pra fim_jogo
	j começo # senao, pula pro começo
# o jogo terminou:
fim_jogo:
	print_tab() # imprime o tab finalizado:
	nova_lin()
	lw $t0, vencedor # carrega o valor de quem venceu (0 = velha / 1 = p1 / 2 = p2)
	beq $t0, 1, p1_win
	beq $t0, 2, p2_win
	j velhou
p1_win:
	la $a0, msg_fim_jog1
	li $v0, 4
	syscall
	j fim
p2_win:
	la $a0, msg_fim_jog2
	li $v0, 4
	syscall
	j fim
velhou:
	la $a0, msg_fim_velha
	li $v0, 4
	syscall
fim:

