
;------------------------------------------------
;	PRINT AX IN BIN
;------------------------------------------------
; ENTRY:	AX = NUM
;			BH = X LEFT CORNER COORDS [0; 79]
;			BL = Y LEFT CORNER COORDS [0; 24]
; EXIT:		NONE
; EXPECTS:	ES = 0b800h (VIDEO SEGMENT)
; DESTROYS:	NONE 
;------------------------------------------------

bin_len	= 16d							; len of bin str	

PrintBin:	    ; proc				
				
				push di					; push (0)

				push ax dx				; push (2) (3)		

				xor  dx, dx				; i = 0

				.Next:			shr ax, 1				; AX /= 2

								push ax					; push (4)

								jc .One

								.Zero:			mov al, '0'			; '0'
												jmp .End

								.One:			mov al, '1'			; '1'

				.End:			mov ah, 70h				; black on white

								sub di, 2				; print( ax ) // with 1 sym left( 2 bytes )
								stosw 					
								add di, 2				

								pop ax					; pop (4)

								inc dx

								cmp dx, bin_len			; if( dx == bin_len )
								jne __Next

				pop dx ax			; pop  (3) (2)
				pop di				; pop  (0)

				ret
				; endp
