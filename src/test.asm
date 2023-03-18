
section .text

global _start 

extern printf, putchar, puts
extern print_bin, print_hex, print_num

;------------------------------------------------

_start:         ; mov rax, 110d
                ; mov rbx, 2d
                ; call print_num

                push Msg
                call printf

                mov rax, 0x3c       ; exit( 0 )
                xor rdi, rdi
                syscall 

;------------------------------------------------

section .data

Msg:    db      "%% str", 10d, 0

