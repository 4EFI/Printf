
section .text

global main

extern _printf, putchar, puts
extern print_bin, print_hex, print_num

;------------------------------------------------

main:           push 10 
                push Str
                push 20
                push 16
                push 10
                push 'v'
                push Msg
                call _printf

                mov rax, 0x3c       ; exit( 0 )
                xor rdi, rdi
                syscall 

;------------------------------------------------

section .data

Msg:    db      "%c %d %b %o %s %x str", 10d, 0
Str:    db      "Hihiha", 0

