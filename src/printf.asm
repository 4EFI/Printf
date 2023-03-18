
section .text

;------------------------------------------------
;   printf( str, ... )
;------------------------------------------------

printf:         ; proc        

                

                ret
                ; endp

;------------------------------------------------
;   putchar( char* ch_ptr )
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
;   puts( char* str_ptr )
;------------------------------------------------
; entry:    rsi = str_ptr
; exit:     none
; expects:  end sym = '\0'
; destroys: none
;------------------------------------------------

global puts

puts:           ; proc

                push rsi

                .Next:          cmp byte [rsi], 0   ; if( curr_sym == '\0' )
                                je .End

                                call putchar
                                inc  rsi            ; str_ptr++

                                jmp .Next
                .End:

                pop rsi

                ret
                ; endp

;------------------------------------------------


; %include "num_cnvrt.asm"
                
