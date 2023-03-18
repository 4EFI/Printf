
section .text
global _start 
extern putchar
extern printbin

;------------------------------------------------

_start:         mov  rsi, Msg
                call putchar

                mov rax, 8d
                call printbin

                mov rax, 0x3c       ; exit( 0 )
                xor rdi, rdi
                syscall 


;------------------------------------------------

section .data

Msg:    db      "test str"

