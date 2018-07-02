jmp main

Aim_Pos: 	var #1
Aim_Crct:	var #1
Duck_Pos1:  var #1
Duck_Stt1:  var #1
Posi:		var #1
Soma:		var #1
Path:		var #19

static Path + #0, #544
static Path + #1, #470
static Path + #2, #556

static Path + #3, #397
static Path + #4, #311
static Path + #5, #385
static Path + #6, #299
static Path + #7, #373
static Path + #8, #287
static Path + #9, #361

static Path + #10,#204
static Path + #11,#130
static Path + #12,#216
static Path + #13,#144
static Path + #14,#230
static Path + #15,#156
static Path + #16,#242
static Path + #17,#170
static Path + #18,#256

main:
	loadn r0, #580		; Posicao inicial da mira, centro da tela
	loadn r1, #'>'		; Caracter que representa a mira
	loadn r2, #2304		; Cor vermelha
	add r1, r2, r1		; Define o caracter mira vermelho para auxiliar na impressao	
	
	store Aim_Pos, r0
	store Aim_Crct, r1
	
	loadn r3, #544		; Posição inicial do pato1
	loadn r4, #'7'		; Caracter para o pato
	loadn r5, #3584		; Cor acqua
	add r4, r5, r4
	loadn r6, #0

	store Duck_Pos1, r3
	store Duck_Stt1, r4
	store Posi, r6
	
	call Move_Duck
	
	halt

; ================== MIRA ======================	
Move_aim:
	load r0, Aim_Pos
	load r1, Aim_Crct
	
	load r4, Soma			; A cada 'n' movimentos da mira, o pato muda de lugar
	loadn r3, #5			; Carrega a soma, compara com 'n', se atingiu, desenha um novo pato
	cmp r4, r3
	jeq Erase_Duck
	
	inchar r2
	
	loadn r3, #100	; char r4 = 'd'
	cmp r2, r3
	jeq Move_Right
	
	loadn r3, #115	; char r4 = 's'
	cmp r2, r3
	jeq Move_Down
	
	loadn r3, #97	; char r4 = 'a'
	cmp r2, r3
	jeq Move_Left
	
	loadn r3, #119	; char r4 = 'w'
	cmp r2, r3
	jeq Move_Up
	
	jmp Move_aim
		
Move_Up:		
	loadn r2, #40
	div r2, r0, r2
	loadn r3, #0
	cmp r2, r3
	jeq Print_Aim

	loadn r2, #127
	outchar r2, r0
			
	loadn r2, #40	
	sub r0, r0, r2
	jmp Print_Aim
				
Move_Down:		
	loadn r2, #40
	div r2, r0, r2
	loadn r3, #29
	cmp r2, r3
	jeq Print_Aim

	loadn r2, #127
	outchar r2, r0
			
	loadn r2, #40	
	add r0, r0, r2
	jmp Print_Aim
								
Move_Left:		
	loadn r2, #40
	mod r2, r0, r2
	loadn r3, #0
	cmp r2, r3
	jeq Print_Aim

	loadn r2, #127
	outchar r2, r0
			
	loadn r2, #1	
	sub r0, r0, r2
	jmp Print_Aim
					
Move_Right:		
	loadn r2, #40
	mod r2, r0, r2
	loadn r3, #39
	cmp r2, r3
	jeq Print_Aim

	loadn r2, #127
	outchar r2, r0
			
	loadn r2, #1	
	add r0, r0, r2
	
Print_Aim:
	outchar r1, r0
	 
	store Aim_Pos, r0
	store Aim_Crct, r1
		
	load r2, Soma		; Incrementa Soma
	loadn r3, #1
	add r2, r2, r3
	store Soma, r2
	
	call Hit

; ================== PATO =====================
Move_Duck:
	loadn r0, #Path			; Carrega o endereço do vetor de posições
	load r1, Posi			; Carrega a posição do pato
	load r4, Duck_Stt1		; Carrega o caracter
	loadn r5, #1			; Avança um caractere
	loadn r6, #38			; Avança uma linha
	
	add r2, r1, r0			; Obtem o endereço adequado do vetor
	loadi r3, r2			; Carrega o conteudo desse vetor
		
	store Duck_Pos1, r3
	
	outchar r4, r3			; Imprime primeiro caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime segundo caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime terceiro caracter

	add r3, r3, r6			
	outchar r4, r3			; Imprime quarto caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime quinto caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime sexto caracter

	add r3, r3, r6			
	outchar r4, r3			; Imprime sétimo caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime oitavo caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime nono caracter	
	
	;add r1, r1, r5			; Salva a nova posição no vetor
	;store Posi, r1	
	
	; Limpa a soma
	loadn r0, #0
	store Soma, r0

	jmp Hit
	
; ================== HIT =======================
Hit:
	load r0, Duck_Pos1		; Carrega a posição do pato1
	load r1, Aim_Pos		; Carrega a posição da mira
	loadn r2, #1
	loadn r3, #38
	
	loadn r4, #'x'
	outchar r4, r0
	
	loadn r4, #'y'
	outchar r4, r1
	
	cmp r0, r1				; Compara a primeira posição
	jeq Sucesso
	
	add r0, r2, r0			; Compara a segunda posição
	cmp r0, r1
	jeq Sucesso
		
	add r0, r2, r0			; Compara a terceira posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r3, r0			; Compara a quarta posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r2, r0			; Compara a quinta posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r2, r0			; Compara a sexta posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r3, r0			; Compara a sétima posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r2, r0			; Compara a oitava posição
	cmp r0, r1
	jeq Sucesso
	
	add r0, r2, r0			; Compara a nona posição
	cmp r0, r1
	jeq Sucesso
	; Se chegou aqui, falhou
	
	
	jmp Move_aim	

Sucesso:
	loadn r0, #120		; Posição inicial do pato1
	loadn r1, #'9'		; Caracter para o pato
	loadn r2, #3584		; Cor acqua
	add r1, r2, r1
	
	outchar r1, r0
	
	halt
		
Erase_Duck:
	loadn r0, #Path			; Carrega o endereço do vetor de posições
	load r1, Posi			; Carrega a posição do pato
	loadn r4, #0			; Carrega o caracter
	loadn r5, #1			; Avança um caractere
	loadn r6, #38			; Avança uma linha
	
	add r2, r1, r0			; Obtem o endereço adequado do vetor
	loadi r3, r2			; Carrega o conteudo desse vetor
		
	outchar r4, r3			; Imprime primeiro caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime segundo caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime terceiro caracter

	add r3, r3, r6			
	outchar r4, r3			; Imprime quarto caracter
	
	add r3, r3, r5			
	outchar r4, r3			; Imprime quinto caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime sexto caracter

	add r3, r3, r6			
	outchar r4, r3			; Imprime sétimo caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime oitavo caracter

	add r3, r3, r5			
	outchar r4, r3			; Imprime nono caracter	
	
	add r1, r1, r5			; Salva a nova posição no vetor
	store Posi, r1	
	
	jmp Move_Duck
