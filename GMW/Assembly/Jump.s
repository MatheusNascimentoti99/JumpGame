#############################################################################################
# Descrição: Jogo de salto simples para uma fpga											#
# 																							#
# Autores: 	Gustavo "Kowaski" Alves,														#
#			Matheus "Rico" Nascimento e 													#		
#			William "Capitão" Soares														#
#																							#
# Componente Curricular: Sistemas Digitais	 												#
# Concluido em: 01/12/2019	<- ISSO DAQUI SERIA UM SONHO
# Concluido em: 14/12/2019	<- NÃO É UM SONHO, MAS TÁ BOM									#
# Declaro que este código foi elaborado por nós de forma coletiva e não contém nenhum 		#
# trecho de código de outro grupo ou de outro autor, tais como provindos de livros e 		#
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
	.equ LCDdown, 0b11000000 # Cursor na linha 2
	.equ BUTTON, 0x2060 # Endereço de memória do botão de pular
	.equ PAUSE, 0x2050 # Endereço de memória do pause
	.equ LEDLOSE, 0x2040 # Endereço de memória do Led de derrota
	.equ LEDPAUSE, 0x2070 # Endereço de memória do Led de pausar
	#LCD Characters
	.equ blank, 0b10100000     #
	.equ capital_p, 0b01010000
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
	.equ perso, 0b10101011
	.equ bloco, 0b11011011
	.equ count, 0x7a120	 # contador de 500.000 para delay dos blocos
	.equ baseNumbers, 0b00110000
	.data 
	cenario: .word 0,0,1,1,0,0,0,1,1,1,0,0,1,1,1,1 # Pré alocação dos blocos que possibilita a manipulação deles sem precisar trocar informações com o lcd
	.global main
	.text

#############################################################
# Inicializa e atribui os valores de manipulação do LCD no 	#
# r23, Led pause no r22, o dip pause no r21, Button no r20, #
# LED de derrota no r19 e atribui um Timer ao r18 	        #
# , r17 é o bloco, r16 é o personagem, r15 é o espaço, 		#
# r14 é o score.											#	
#############################################################
main:	
	addi r1, r0, 1
	call initLCD
	movia r23, clear
	movia r18, count # Timer
	custom 0, r3, r0, r23			
	movia r22, LEDPAUSE	
	movia r21, PAUSE		
	movia r20, BUTTON	
	movia r19, LEDLOSE	
	movia r17, bloco
	movia r16, perso
	movia r15, esp
	movia r14, 0	# Score
	mov r14, r0	           #Zerando o score
	mov r12, r0 			#valor da centena
	mov r13, r0
	call inicio
	br start
#Carregar tudo para o LCD antes de dar start

#########################
# Inicialização do LCD	#
#########################
initLCD:
		movia r23, init1
		custom 0, r3, r0, r23 #Limpar Busy Flag
		custom 0, r3, r0, r23
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

#################################################
# Após inicializar tudo o start espera o 		#
# primeiro toque no botão para começar o jogo. 	#
#################################################
start:  
	mov r4, r0
	ldw r8, 0(r20)			# Pega o valor do button de pulo
	bne r8, r0, start		# Loop na tela inicial
	movia r23, clear		# limpa o LCD
	custom 0, r3, r0, r23
	br verifica_pause		# Antes de iniciar a partida, verifica se o botão de pause está acionado

#################################################
# Liga um led sinalizando que está pausado		#
# e sempre verifica se ainda está pausado,		#
# caso não esteja a operação volta para o loop	#
#################################################
verifica_pause:
	stw r1, 0(r22)						# Aciona o LED para informar que o jogo está em estado de pause		
	ldw r8, 0(r21)						# Valor do dip de pause
	beq r8, r1, verifica_pause			# loop até o jogador despausar	
	stw r0, 0(r22)
	ldw r8, 0(r20)
	movia r23, init9
	custom 0, r3, r0, r23
	movia r23, LCDdown
	custom 0, r3, r0, r23
	custom 0, r3, r0, r23
	br movingPerson

#################################################
# Core para a movimentação dos blocos			#
# r9 recebe o array com os blocos do senário,	#
#################################################
gameplay:	
	movia r9, cenario
	addi r2, r0, 16
	br moveCen

moveCen:
	beq r2, r0, movingOn
	ldw r6, 0(r9)
	beq r6, r0, adsEsp         	# Se for 0 escreve espaço
	bne r6, r0, adsBlo			# Se for 1 escreve bloco
	addi r2, r0, 16				# Parece que nunca será alcançado, se não for, retira do código
	br moveCen					# Parece que nunca será alcançado

adsEsp:
		movia r11, esp
		add r10, r0, r11
		custom 0, r3, r1, r10
		addi r9, r9, 4
		subi r2, r2, 1
		br moveCen
adsBlo:
		movia r11, bloco
		add r10, r0, r11
		custom 0, r3, r1, r10
		addi r9, r9, 4
		subi r2, r2, 1
		br moveCen


movingOn:
		movia r9, cenario			# Move a base do vetor para o registrador r9
		addi r2, r0, 16
		br moving					# O objetivo dele é colocar a primeira posição do vetor para a ultima sem comprometer a ordem do array
moving:		
		beq r2, r0, delay			# Se r2 for igual a 0 o processo vai para o delay
		call swap
		addi r9, r9, 4 				# Vai para a proxima posição do array "r9[i] = r9[i+1]"
		br moving
swap:								# Ele troca a primeira posição para a segunda posição
		ldw r6, 0(r9)
		ldw r7, 4(r9)
		stw r7, 0(r9)
		stw r6, 4(r9)
		subi r2, r2, 1
		ret

#################################################
# Tempo para os blocos se moverem				#
# r18 é recrementado até chega a 0, para que	#
#a velocidade com que os blocos se movem sejam 	#
#visiveis ao olho humano						#
#################################################
delay:			
	subi r18, r18, 1
	bne r18, r0, delay
	movia r18, count
	br verifica_pause				# após passar o tempo suficiente para mover os blocos, o jogo retorna para o inicio, 
									#com o objetivo de realizar todas as verificações necessária novamente

#################################################################################
# Movendo o personagem															#
# Pega o valor do cenario, para verificar a localização do próximo bloco		#
# Verifica condições para o jogador na parte de baixo do cenário				#
# 		Colidir ou pular														#
# Verifica condições em casos do jogador estiver em cima do bloco				#
#		Descer ou ficar															#					
#################################################################################
movingPerson:
	addi r5, r5, 1
	#add r14, r14, r1
	call scoreDec_Uni
	call is_hund
	movia r9, cenario					#Ponteiro do array que contém o cenário
	ldb r6, 0(r9)						#Recebe o primeiro elemento do cenário
	beq r8, r0, buttonUp				#Passa a verificar as condições caso o jogador pule
	beq r8, r1, buttonDown				#Passa a verificar as condições caso o jogador não pule
	br movingPerson						

buttonDown:
	beq r4, r1, inUp			#Verifica se o jogador está em cima do bloco
	bne r6, r0, collider		#Verifica se o próximo elemento do cenário é um bloco
	br moveDown					#Se nenhuma das situações acontecerem, então ele se mantém na parte de baixo

buttonUp:
	addi r13, r13, 1
	call check_up  

up:	
	beq r4, r1, inUp			#Verifica se o jogador está em cima do bloco
	beq r6, r1, increment_score	#Vai pular um bloco, logo ganhará um ponto			
	br moveUp					#Caso ele não esteja na parte de cima, então será realizada a ação de pular

check_up:
	beq r5, r13, noUp			#Verifica se o jogador está pressionando o botão
	mov r5, r0
	mov r13, r0
	br up

noUp:
	beq r4, r1, inUp		#Se onde o jogador estever houver bloco, então ele perderá a partida	
	beq r6, r1, collider
	mov r5, r0
	mov r13, r0
	br moveDown

moveUp:
	
	movia r23, LCDup
	custom 0, r3, r0, r23				#Para escrever o personagem na parte superior
	custom 0, r3, r1, r16

	mov r23, r0
	movia r23, LCDdown
	custom 0, r3, r0, r23			#Para deixar o cursor na linha de baixo novamente
	addi r4, r0, 1
	br gameplay

moveDown:
	mov r23, r0
	movia r23, LCDdown
	custom 0, r3, r0, r23			#Move o personagem para baixo
	custom 0, r3, r1, r16
	add r4, r0, r0
	br gameplay

inUp:
	bne r6, r1, moveDown			#Se o próximo elemento do cenario for um espaço, então o personagem vai descer do bloco
	br moveUp						#Caso contrário, então ele continua na parte de cima

collider:
	stw r1, 0(r22)					#Aciona a LED de gameOver
	br main						#retorna para a tela inicial do jogo
	

increment_score:
	addi r14, r14, 1
	br moveUp

#################################################################################
# Placar																		#
# Verifica a casa decimal da pontuação											#
# exemplo: se r14 < 9, r6 recebe 0, então vai para a função de unidade			#					
#################################################################################
scoreDec_Uni:
	movia r10, baseNumbers
	cmpleui r6, r14, 99
	beq r6, r0, hund
	cmpgtui r6, r14, 9 
	beq r6, r0, uni
	cmpgtui r6, r14, 19
	beq r6, r0, dec1
	cmpgtui r6, r14, 29
	beq r6, r0, dec2
	cmpgtui r6, r14, 39
	beq r6, r0, dec3
	cmpgtui r6, r14, 49
	beq r6, r0, dec4
	cmpgtui r6, r14, 59
	beq r6, r0, dec5
	cmpgtui r6, r14, 69
	beq r6, r0, dec6
	cmpgtui r6, r14, 79
	beq r6, r0, dec7
	cmpgtui r6, r14, 89
	beq r6, r0, dec8
	cmpgtui r6, r14, 99
	beq r6, r0, dec9
	ret

uni:
	addi r23, r0, 0x0e
	addi r6, r10, 0
	addi r23, r23, 0x80
	custom 0, r3, r0, r23		#Move o cursor para o local do placar para o local da dezena
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	addi r23, r0, 0x0F
	add r10, r10, r14
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar para o local da unidade
	custom 0, r3, r1, r10
	ret
dec1:
	addi r23, r0, 0x0e
	addi r6, r10, 1
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 10
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret
dec2:
	addi r23, r0, 0x0e
	addi r6, r10, 2
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 20
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret
dec3:
	addi r23, r0, 0x0e
	addi r6, r10, 3
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 30
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec4:
	addi r23, r0, 0x0e
	addi r6, r10, 4
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 40
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec5:
	addi r23, r0, 0x0e
	addi r6, r10, 5
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 50
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec6:
	addi r23, r0, 0x0e
	addi r6, r10, 6
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 60
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec7:
	addi r23, r0, 0x0e
	addi r6, r10, 7
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 70
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec8:
	addi r23, r0, 0x0e
	addi r6, r10, 8
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 80
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

dec9:
	addi r23, r0, 0x0e
	addi r6, r10, 9
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	subi r6, r6, 90
	addi r23, r0, 0x0F
	add r6, r6, r10 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret

#################################################################################
# Incrementar centena															#
# Caso o valor do contador ultrapasse 99, então essa função é chama para -		#
# incrementa o valor da centena													#
# exemplo: se r14 < 99, r12 recebe r12 + 1, então retorna para função de dezena	#					
#################################################################################
hund:
	addi r23, r0, 0x0D
	addi r6, r10, 1
	add r14, r0, r0
	addi r12, r12, 1 
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local da centena
	custom 0, r3, r1, r6			#Envia o valor da centena

	addi r23, r0, 0x0e
	addi r6, r10, 0
	addi r23, r23, 0x80
	custom 0, r3, r0, r23
	custom 0, r3, r1, r6
	#stb r11, 14(r23)
	add r6, r0, r14

	addi r23, r0, 0x0F
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local do placar
	custom 0, r3, r1, r6
	ret
	
is_hund:							#Verifica se a pontuação do jogador já está na casa das centenas
	bne r12, r0, decimal_hund
	ret

#########################################################################################################################################
# Escreve valor da centena																												#
# Caso o pontuação já esteja com mais de 99, então essa função é chamada para imprimir o valor da centena								#
# 																																		#					
#########################################################################################################################################
decimal_hund:						
	movia r10, baseNumbers
	addi r23, r0, 0x0D
	add r6, r10, r12
	addi r23, r23, 0x80
	custom 0, r3, r0, r23			#Move o cursor para o local da centena
	custom 0, r3, r1, r6			#Envia o valor da centena
	ret


