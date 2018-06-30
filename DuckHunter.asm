jmp main

Aim_Pos: 	var #1
Aim_Crct:	var #1

main:
	loadn r0, #579		; Posicao inicial da mira, centro da tela
	loadn r1, #'>'		; Caracter que representa a mira
	loadn r2, #2304		; Cor vermelha
	add r1, r2, r1		; Define o caracter mira vermelho para auxiliar na impressao	

	store Aim_Pos, r0
	store Aim_Crct, r1
		
	call Move_aim

	loadn r1, #0
	
;	store Duck_Pos1, r0
;	store Duck_Stt1, r1
	
;	call Move_Duck
	
	halt
	

; ================== MIRA ======================	
Move_aim:
	load r0, Aim_Pos
	load r1, Aim_Crct
	
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
		
	
	jmp Move_aim
	



	
	
	