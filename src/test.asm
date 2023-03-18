
section .text
global _start

;------------------------------------------------

_start:         mov  rsi, Msg
                call putchar

                mov rax, 0x3c       ; exit( 0 )
                xor rdi, rdi
                syscall


;------------------------------------------------

section .data

Msg:    db      "test str"

