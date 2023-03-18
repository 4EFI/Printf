
;------------------------------------------------
;	print ax in bin
;------------------------------------------------
; entry:	ax = num
; exit:		none
; destroys:	none 
;------------------------------------------------

section .text

extern putchar
global print_bin

print_bin:	    ; proc				

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
;	print ax in hex
;------------------------------------------------
; entry:	ax = num
; exit:		none
; destroys:	none  
;------------------------------------------------

global print_hex

print_hex		; proc
							
				push rax 
				push rcx
				push rdx

				xor rdx, rdx	; i = 0

				.Next:			xor  cx, cx			; numShifts = 0			
	
								push rdx
								xor  rdx, rdx		; DX = 0 ( digit in hex )
								
								.Shift:			shr ax, 1		; AX /= 2
		
												jnc .End

												.One:			push rax		; push (6)
																mov  ax, 1 		; AX = 0001b
																shl  ax, cl		; DX += 2^CX
																add  dx, ax 
																pop	 rax		; pop  (6)
								
								.End:			inc cx			; shifts counter ++
												cmp cx, 4d		; if( numShifts == 4 )
												jne .Shift

								mov cx, ax			; CX = AX
								
								cmp dx, 10d			; if( DX >= 10 )
								jge .Sym

								.Digit:  		add  dx, 48d		; print( DX + '0' )
												xor  rax, rax
												mov  al, dl	
												jmp .Skip

								.Sym:			sub  dx, 10			; print( DX - 10 + 'A' )
												add  dx, 65d
												xor  rax, rax
												mov  al, dl

				.Skip:  		pop  rdx
								push rax			; for reverse print	

								mov ax, cx			; AX = CX

								inc dx				; i++

								cmp ax, 0			; if( ax > 0 )
								jg .Next

				.Print:			mov  rsi, rsp 		; reverse print
								call putchar 	
								pop  rax						

								dec dx
								cmp dx, 0
								jne .Print 			; if( i != 0 )

				pop rdx
				pop rcx
				pop rax

				ret
				endp

;------------------------------------------------