
extern print_bin, print_hex, print_num

;------------------------------------------------
;   printf( str, ... )
;------------------------------------------------

section .data

JumpTable:  times '%'               dq None         ; [ '\0'; '%' ) 
                                    dq Percent      ; '%%'
            times ( 'b'-'%' - 1 )   dq None         ; ( '%'; 'b' ) 
                                    dq Bin          ; '%b'
                                    dq Char         ; '%c'
                                    dq Decimal      ; '%d'

section .text

%macro	        GetArgAddr 0
                mov  rsi, rbp       ; rsi = rbp + 8 + 8*args_counter
                add  rsi, 8
                shl  rcx, 3
                add  rsi, rcx
                shr  rcx, 3
                inc  rcx            ; args_counter++
%endmacro

None:       ; jmp

Percent:        call putchar
                inc  rsi
                ret

Char:           push rsi
                GetArgAddr
                call putchar
                pop  rsi
                inc  rsi
                ret

Bin:            push rsi
                GetArgAddr 
                mov  rax, [rsi]
                call print_bin
                pop  rsi
                inc  rsi
                ret

Decimal:        push rsi
                GetArgAddr 
                mov  rax, [rsi]
                mov  rbx, 10d
                call print_num
                pop  rsi
                inc  rsi
                ret

;------------------------------------------------

global printf

printf:         ; proc        

                push rbp
                mov  rbp, rsp
                add  rbp, 16d               ; + ret_addr + push_rbp 

                push rsi
                mov  rsi, [rbp]             ; rsi = str addr

                push rbx
                push rcx                    

                xor rcx, rcx                ; args_counter = 0

                .Next:          cmp byte [rsi], 0       ; if( curr_sym == '\0' )
                                je .End

                                cmp byte [rsi], '%'     ; if( curr_sym == '%' )
                                jne .NotPercent

                                inc  rsi
                                xor  rbx, rbx
                                mov  bl, [rsi]
                                push .Next
                                jmp [JumpTable + 8*rbx] ; go to JumpTable

                                .NotPercent:

                                call putchar
                                inc  rsi

                                jmp .Next       
                .End:

                pop rcx
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
                
