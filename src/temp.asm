
;------------------------------------------------
;	PRINT AX IN HEX
;------------------------------------------------
; ENTRY:	AX = NUM
;			BH = X LEFT CORNER COORDS [0; 79]
;			BL = Y LEFT CORNER COORDS [0; 24]
; EXIT:		NONE
; EXPECTS:	ES = 0b800h (VIDEO SEGMENT)
; DESTROYS:	NONE  
;------------------------------------------------

hex_len	= 16d							; len of hex str	

PrintHex		proc
				
				push di					; push (0)
				
				push ax					; push (1)

				call GetVideoPos 		; AX = Video position from (X; Y)
				mov di, hex_len * 2d 	; i = hex_len * 2 + AX
				add di, ax
				std 

				pop  ax					; pop  (1)

				push ax cx dx 			; push (2) (3) (4)

				xor dx, dx				; i = 0

				__Next:			mov cx, 0			; shifts counter			
	
								push dx				; push (5)
								mov  dx, 0			; DX = 0
								
								__Shift:		shr ax, 1		; AX /= 2
		
												jnc __End

												__One:			push ax			; push (6)
																mov  ax, 1 		; AX = 0001b
																shl  ax, cl		; DX += 2^CX
																add  dx, ax 
																pop	 ax			; pop  (6)
								
								__End:			inc cx			; shifts counter ++
												cmp cx, 4d		; if( numShifts == 4 )
												jne __Shift

								mov cx, ax			; CX = AX
								
								cmp dx, 10d			; if( DX >= 10 )
								jge __Sym

								__Digit:		add dx, 48d		; print( DX + '0' )
												mov al, dl		
												jmp __Print

								__Sym:			sub dx, 10		; print( DX - 10 + 'A' )
												add dx, 65d
												mov al, dl

				__Print:		pop dx				; pop  (5)

								mov ah, 70h			; black on white

								sub di, 2			; print( ax ) // with 1 sym left( 2 bytes )
								stosw 					
								add di, 2				

								mov ax, cx			; AX = CX

								inc dx				; i++

								cmp dx, hex_len		; if( dx == hex_len )
								jne __Next

				pop dx cx ax			; pop  (4) (3) (2)
				pop di					; pop  (0)

				ret
				endp

;------------------------------------------------
;	PRINT AX IN DEC
;------------------------------------------------
; ENTRY:	AX = NUM
;			BH = X LEFT CORNER COORDS [0; 79]
;			BL = Y LEFT CORNER COORDS [0; 24]
; EXIT:		NONE
; EXPECTS:	ES = 0b800h (VIDEO SEGMENT)
; DESTROYS:	NONE
;------------------------------------------------

dec_len	= 5d	

PrintDec		proc

				push di					; pop  (0)
				
				push ax					; push (1)

				call GetVideoPos 		; AX = Video position from (X; Y)
				mov di, dec_len * 2d 	; i = dec_len * 2 + AX
				add di, ax
				std 

				pop  ax					; pop  (1)

				push ax cx dx			; push (2) (3) (4)

				xor dx, dx				; i = 0
				mov cx, 10d				; CX = 10

				__Next:			push dx				; push (5)

								xor dx, dx			; DX = 0

								div  cx				; AX /= 10

								push ax				; push (6)	

								add  dl, 48d		; print( DL + '0' )
								mov  al, dl	

								mov  ah, 70h		; black on white	

								sub di, 2			; print( ax ) // with 1 sym left( 2 bytes )
								stosw 					
								add di, 2				

								pop ax				; pop  (6)
								pop dx				; pop  (5)

								inc dx

								cmp dx, dec_len		; if( DX == dec_len )
								jne __Next
				
				pop dx cx ax			; pop  (4) (3) (2)
				pop di					; pop  (0)

				ret 
				endp

;------------------------------------------------
;	PRINT AX IN BIN/HEX/DEC
;------------------------------------------------
; ENTRY:	AX = NUM
;			BH = X LEFT CORNER COORDS [0; 79]
;			BL = Y LEFT CORNER COORDS [0; 24]
; EXIT:		NONE
; EXPECTS:	ES = 0b800h (VIDEO SEGMENT)
; DESTROYS:	NONE  
;------------------------------------------------

PrintNum		proc

				push bx					; push (1)

				call PrintBin

				add bh, bin_len + 1d	; X 
				call PrintHex

				add bh, hex_len + 1d	; X
				call PrintDec

				pop bx					; pop  (1)

				ret
				endp

;------------------------------------------------