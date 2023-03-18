
section .text

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

global putchar

putchar:        ; proc

                push rax
                push rdi
                push rdx
                push rcx
                push r11

                mov rax, 1      ; write( edi = stdout, rsi = ch_ptr, rdx = 1 ( len ) )
                mov rdi, 1      
                mov rdx, 1      
                syscall         

                pop r11
                pop rcx
                pop rdx
                pop rdi
                pop rax

                ret
                ; endp

;------------------------------------------------

; %include "num_cnvrt.asm"
                
