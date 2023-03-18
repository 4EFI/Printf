
;------------------------------------------------
;   printf( str, ... )
;------------------------------------------------

section .data

JumpTable:  times '%'       dq None         ; from '\0' to '%' 

                            dq Percent      ; '%%'
            ;times 

section .text

None:       ; jmp

Percent:        call putchar
                inc  rsi
                ret

global printf

printf:         ; proc        

                push rbp
                mov  rbp, rsp
                add  rbp, 16d               ; + ret_addr + push_rbp 

                push rsi
                mov  rsi, [rbp]             ; rsi = str addr

                push rbx

                .Next:          cmp byte [rsi], 0       ; if( curr_sym == '\0' )
                                je .End

                                cmp byte [rsi], '%'     ; if( curr_sym == '%' )
                                jne .NotPercent

                                inc  rsi
                                xor  rbx, rbx
                                mov  bl, [rsi]
                                push .Next
                                jmp [JumpTable + 8*rbx]

                                ; None:

                                ; Percent:

                                .NotPercent:

                                call putchar
                                inc  rsi

                                jmp .Next       
                .End:

                pop rbx
                pop rsi
                pop rbp

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
                
