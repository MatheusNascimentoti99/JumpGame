.data		

	# Other
	.equ clear, 0x01 #Clear display -> '00000001'
	

	# LCD Initialization commands
	.equ init1, 0b00111000 # 38 function set 2 line
	.equ init2, 0b00111001 # 39 extendsion mode
	.equ init3, 0b00010100 # 14 OSC frequency
	.equ init4, 0b01011110 # 5e Icon display on booster circuit on
	.equ init5, 0b01101101 # 6a follower circuit on with 010
	.equ init6, 0b01110000 # 78 Contrast set for 1000
	.equ init7, 0b00001100 # c display on cursor off
	.equ init8, 0b00000110 # 6 Entry mode L/R
	.equ init9, 0b00000001 # 1 Clear

	# LCD DDRAM
	.equ upper_row, 0b00000010 # Address '00' 
	.equ down_row, 0b11000000 # Address '40'


	#LCD Characters
	.equ blank, 0b10100000
	.equ capital_p, 0b01010000
	.equ r, 0b01110010
	.equ s, 0b01110011
	.equ i, 0b01101001
	.equ o, 0b01101111
	.equ n, 0b01101110
	.equ e, 0b01100101
	.equ capital_s, 0b01010011
	.equ t, 0b01110100
	.equ a, 0b01100001

	# Push button addresses:
	.equ control_btn, 0x0000 # colocar o endereço do botão # (Play/Pause/Start) control
#	.equ jump, 0x0000

.global _start
_start: 
	
	addi r1, r0, 1

	call init
	movia r14, clear
	custom 0, r3, r0, r14

	movia r14, down_row
	custom 0, r3, r0, r14 #joga o cursor na posiçao 00

	addi r10, r0, 0b01100111 
	custom 0, r3, r1, r10 # escreve g

		
	br end
	
init:
		movia r14, init1
		custom 0, r3, r0, r14 #Limpar Busy Flag
		custom 0, r3, r0, r14 #
		movia r14, init2
		custom 0, r3, r0, r14
		movia r14, init3
		custom 0, r3, r0, r14
		movia r14, init4
		custom 0, r3, r0, r14
		movia r14, init5
		custom 0, r3, r0, r14
		movia r14, init6
		custom 0, r3, r0, r14
		movia r14, init7
		custom 0, r3, r0, r14
		movia r14, init8
		custom 0, r3, r0, r14
		movia r14, init9
		custom 0, r3, r0, r14
		movia r14, clear
		custom 0, r3, r0, r14

		ret # Retorna para a main	

