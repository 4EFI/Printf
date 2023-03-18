
;------------------------------------------------
;	print ax in bin
;------------------------------------------------
; entry:	ax = num
; exit:		none
; destroys:	none 
;------------------------------------------------

section .text

extern putchar
global printbin

printbin:	    ; proc				

				push rax 
				push rdx	

				xor  dx, dx		; i = 0

				.Next:			shr ax, 1		; AX /= 2			

								jc .One

								.Zero:			push '0'		; '0'
												jmp .End

								.One:			push '1'		; '1'

				.End:			inc dx				; i++

								cmp ax, 0			; if( ax > 0 )
								jg .Next

				.Print:			mov  rsi, rsp 		; reverse print
								call putchar 	
								pop  rax						

								dec dx
								cmp dx, 0
								jne .Print 			; if( i != 0 )

				pop rdx
				pop rax			

				ret
				; endp

;------------------------------------------------