#############################################################################################
# Descrição: Jogo de salto simples para uma fpga											#
# 																							#
# Autores: 	Gustavo "Kowaski" Alves,														#
#			Matheus "Rico" Nascimento e 													#		
#			William "Capitão" Soares														#
#																							#
# Componente Curricular: Sistemas Digitais	 												#
# Concluido em: 01/12/2019	<- ISSO DAQUI SERIA UM SONHO									#
# Declaro que este código foi elaborado por mim de forma individual e não contém nenhum 	#
# trecho de código de outro colega ou de outro autor, tais como provindos de livros e 		#
# apostilas, e páginas ou documentos eletrônicos da Internet. Qualquer trecho de código		#
# de outra autoria que não a minha está destacado com uma citação para o autor e a fonte	#
# do código, e estou ciente que estes trechos não serão considerados para fins de avaliação.#
#############################################################################################

	.data
	.equ clear, 0x01 #Clear display -> '00000001'
	.equ init1, 0b00111000 # 38 function set 2 line
	.equ init2, 0b00111001 # 39 extendsion mode
	.equ init3, 0b00010100 # 14 OSC frequency
	.equ init4, 0b01011110 # 5e Icon display on booster circuit on
	.equ init5, 0b01101101 # 6a follower circuit on with 010
	.equ init6, 0b01110000 # 78 Contrast set for 1000
	.equ init7, 0b00001100 # c display on cursor off
	.equ init8, 0b00000110 # 6 Entry mode L/R
	.equ init9, 0b00000001 # 1 Clear
	.equ LCDup, 0b00000010 # Cursor home, início da linha 1
	.equ LCDdown, 0b11000000 # Cursor na linha 2, mas precisa da adição de 0x14
	.equ BUTTON, 0x2060
	.equ PAUSE, 0x2050
	.equ LEDLOSE, 0x2040
	.equ LEDPAUSE, 0x2070
	#LCD Characters
	.equ blank, 0b10100000     #
	.equ capital_p, 0b01010000 #3Pule para4 4iniciar!4
	.equ r, 0b01110010
	.equ a, 0b01100001
	.equ i, 0b01101001
	.equ e, 0b01100101
	.equ n, 0b01101110
	.equ u, 0b01110101
	.equ l, 0b01101100
	.equ p, 0b01110000
	.equ c, 0b01100011
	.equ excla, 0b00100001
	.equ esp, 0b00100000
	.equ perso, 0b10111101
	.equ bloco, 0b11011011
	.global main
	.text

#############################################################
# Inicializa e atribui os valores da Linha 1 do LCD no 		#
# r23, Linha 2 do LCD no r22, Button no r21, DipS no r20,	#
# LEDs no r19 e atribui um Timer ao r18, r17 é o bloco, 	#
# r16 é o personagem, r15 é o espaço, r14 é o score, 		#
# r13 é a frequencia em que gera os blocos.......			#	
main:	
	addi r1, r0, 1
	call initLCD
	movia r23, clear
	custom 0, r3, r0, r23			
	movia r22, LEDPAUSE	
	movia r21, BUTTON		
	movia r20, PAUSE	
	movia r19, LEDLOSE	
	movia r18, 60 	# Timer
	movia r17, bloco
	movia r16, perso
	movia r15, esp
	movia r14, 0	# Score
	movia r13, 0	# BlockGen
	call inicio
	br start
#Carregar tudo para o LCD antes de dar start

##########################
# Inicialização do LCD	#
#########################
initLCD:
		movia r23, init1
		custom 0, r3, r0, r23 #Limpar Busy Flag
		custom 0, r3, r0, r23 #
		movia r23, init3
		movia r23, init2
		custom 0, r3, r0, r23
		custom 0, r3, r0, r23
		movia r23, init4
		custom 0, r3, r0, r23
		movia r23, init5
		custom 0, r3, r0, r23
		movia r23, init6
		custom 0, r3, r0, r23
		movia r23, init7
		custom 0, r3, r0, r23
		movia r23, init8
		custom 0, r3, r0, r23
		movia r23, init9
		custom 0, r3, r0, r23
		movia r23, clear
		custom 0, r3, r0, r23

		ret # Retorna para a main	
#####################################################
# Texto de inicio com uma instrução para o usuário	#
#####################################################
inicio:
		movia r23, LCDup
		custom 0, r3, r0, r23
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, capital_p
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, u
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, l
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, e
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, p
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, a
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, r
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, a
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r23, clear
		movia r23, LCDdown
		custom 0, r3, r0, r23
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, i
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, n
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, i
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, c
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, i
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, a
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, r
		add r10, r0, r11
		custom 0, r3, r1, r10
		movia r11, excla
		add r10, r0, r11
		custom 0, r3, r1, r10
		ret
#FAZER CENARIO INICIAL

#################################################
# Após inicializar tudo o start espera o 		#
# primeiro toque no botão para começar o jogo. 	#
#################################################
start:  
	stw r0, 0(r19)	
	ldw r8, 0(r21)			# Pega o valor do button
	beq r8, r0, loop		
	br start

#################################################
# Liga um led sinalizando que está pausado		#
# e sempre verifica se ainda está pausado,		#
# caso não esteja a operação volta para o loop	#
#################################################
pause:	
	stw r1, 0(r22)			
	ldw r8, 0(r20)			
	beq r8, r0, loop		
	br pause	

########################################################################################################################################

#############################################################
# Fica em um loop infinito, pegando os valores da I/O até	#
# um certo tempo previamente definido vai até moverCenario,	#
# ou se um I/O for alterada ele manda a operação para quem 	#
# computa a informação da determinada I/O alterada			#
#############################################################
loop:	
	stb r0, 0(r22)	
	ldb r8, 0(r20)			
	beq r8, r0, pause	
	ldb r8, 0(r21)			
	beq r8, r0, bounce	
	subi r18, r18, 1
	beq r18, r0, moveScenario
	br loop	

#####################################################################
# Reseta o valor decrementado em r18 e verifica se o personagem está#
# em cima, se estiver ele volta para o loop, senão ele coloca o		#
# personagem na posição acima, no caso, na posição 01 do LCD. 		#
#####################################################################
jump:	
	addi r18, r18, 60 #reseta timer
	ldb r8, 01(r23)
	beq r8, r16, loop
	stb r15, 65(r22)
	stb r16, 01(r23)
	br moveScenario

#####################################################################
# Pega o valor do button pra confirmar se ainda está apertado.		#
# Como o valor é 1 ele já subtrai com o timer já definido 			#
# anteriormente, se esse timer chegar a zero, ele vai para o jump.	#
#####################################################################
bounce:	
	ldb r8, 0(r21)			
	sub r18, r18, r8
	beq r18, r0, jump		
	br bounce				
#VERIFICAR O TIMER


#############################################
# move o que está em LCDdown para esquerda	# 
# fazendo a verificação da colisão			#
#############################################
moveScenario:
	addi r9, r0, 64 #40 em hexa 64 até 79 (4F)
	addi r18, r0, 60 #reseta timer
	stb r15, r9(r22)
	addi r9, r9, 1
	call colision
	addi r9, r9, 1
movingOn:
	ldb r8, r9(r22)
	beq r8, r15, exit
	call swap
exit: 
	addi r9, r9, 1
	cmpgtui r10, r9, 79
	bne r10, r0, blockGen
	br movingOn	
swap: 
	add r10, r0, r9
	subi r10, r10, 1
	stb r17, r10(r22)
	stb r15, r9(r22)
	ret

###################################################
# Gera a frequencia em 5 em 5 que o bloco irá vir #
###################################################
blockGen: 
	cmpgtui r10, r13, 0 
	beq r10, r0, newBlock
	cmpgtui r10, r13, 1
	beq r10, r0, newBlock
	cmpgtui r10, r13, 2
	beq r10, r0, newBlock
	cmpgtui r10, r13, 3
	beq r10, r0, newBlock
	cmpgtui r10, r13, 4
	beq r10, r0, newBlock
	cmpgtui r10, r13, 5
	beq r10, r0, noBlock
	cmpgtui r10, r13, 6
	beq r10, r0, noBlock
	cmpgtui r10, r13, 7
	beq r10, r0, noBlock
	cmpgtui r10, r13, 8
	beq r10, r0, noBlock
	cmpgtui r10, r13, 9
	beq r10, r0, noBlock
	add r13, r0, r0
	br blockGen
newBlock:
	stb r17, 79(r22)
	addi r13, r13, 1
	br score
noBlock:
	stb r15, 79(r22)
	addi r13, r13, 1
	br score

#########################################################
# verifica a colisão do personagem, se ele estiver em 	#
# baixo a como perder e continuar, se estiver em cima 	#
# a chances dele descer ou continuar.					#
#########################################################
colision:
	ldb r8, r9(r22)
	ldb r10, 01(r23)
	ldb r11, 66(r22) #42 em codhex
	beq r8, r16, losing
	beq r8, r15, DownOrContinue
	beq r8, r17, DownOrContinue
losing:
	beq r11, r17, ggwp
	br continue
continue:
	call swap
	br exit
DownOrContinue:
	beq r11, r17, continue
	call downPerson
	br exit
downPerson:
	stb r16, 65(r22)
	stb r15, 01(r23)
	ret

#########################################################
# Pontua a cada vez que finaliza o movimento do cenario #
#########################################################
score:
	addi r14, r14, 1
	cmpgtui r10, r14, 9 
	beq r10, r0, uni
	cmpgtui r10, r14, 19
	beq r10, r0, dec1
	cmpgtui r10, r14, 29
	beq r10, r0, dec2
	cmpgtui r10, r14, 39
	beq r10, r0, dec3
	cmpgtui r10, r14, 49
	beq r10, r0, dec4
	cmpgtui r10, r14, 59
	beq r10, r0, dec5
	cmpgtui r10, r14, 69
	beq r10, r0, dec6
	cmpgtui r10, r14, 79
	beq r10, r0, dec7
	cmpgtui r10, r14, 89
	beq r10, r0, dec8
	cmpgtui r10, r14, 99
	beq r10, r0, dec9
	br cen
uni:
	stb r14, 15(r23)
	br loop
dec1:
	addi r11, r0, 1
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 10
	stb r11, 15(r23)
	br loop
dec2:
	addi r11, r0, 2
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 20
	stb r11, 15(r23)
	br loop
dec3:
	addi r11, r0, 3
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 30
	stb r11, 15(r23)
	br loop

dec4:
	addi r11, r0, 4
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 40
	stb r11, 15(r23)
	br loop

dec5:
	addi r11, r0, 5
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 50
	stb r11, 15(r23)
	br loop

dec6:
	addi r11, r0, 6
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 60
	stb r11, 15(r23)
	br loop

dec7:
	addi r11, r0, 7
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 70
	stb r11, 15(r23)
	br loop

dec8:
	addi r11, r0, 8
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 80
	stb r11, 15(r23)
	br loop

dec9:
	addi r11, r0, 9
	stb r11, 14(r23)
	add r11, r0, r14
	subi r11, r11, 90
	stb r11, 15(r23)
	br loop


#######################################################################
# Good Game Well Played (GGWP) siginifica que o jogo acabou por causa #
# de uma colisão e a operação volta para start, para recomeçar o jogo #
#######################################################################
ggwp:	
	#addi r8, r0, ??			# Tenta ligar todos os leds
	stb r1, 0(r19)	
	#zerar registradores
	movia r8, 0
	movia r9, 0
	movia r10, 0
	movia r11, 0
	br main		