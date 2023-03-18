
section .text
global _start 
extern putchar
extern print_bin, print_hex

;------------------------------------------------

_start:         mov rax, 11d
                call print_hex

                mov rax, 0x3c       ; exit( 0 )
                xor rdi, rdi
                syscall 


;------------------------------------------------

section .data

Msg:    db      "test str"

