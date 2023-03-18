
;------------------------------------------------
;   printf( str, ... )
;------------------------------------------------

printf:         ; proc        

                

                ret
                ; endp

;------------------------------------------------
;   putchar( *ch_ptr )
;------------------------------------------------
; entry:    rsi = ch_ptr
; exit:     none
; destroys: none
;------------------------------------------------

putchar:        ; proc

                ; push rcx r11

                mov rax, 1      ; write( edi = stdout, rsi = ch_ptr, rdx = 1 ( len ) )
                mov rdi, 1      
                mov rdx, 1      
                syscall         

                ; pop r11 rcx

                ret
                ; endp

;------------------------------------------------

; %include "num_cnvrt.asm"
                
