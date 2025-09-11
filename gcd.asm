section .data
    num1 dq 270                ; prvni cislo
    num2 dq 192                ; druhe cislo
    ; pro 270 a 192 je gcd 6

    result_msg db "GCD: "
    newline db 10

section .bss
    result resb 20

section .text
    global _start

_start:
    mov rax, [num1]    ; a
    mov rbx, [num2]    ; b

gcd_loop:
    cmp rbx, 0         ; pokud b == 0 tak gcd_done
    je gcd_done
    xor rdx, rdx       ; vynulujeme rdx,
    div rbx            ; rax / rbx > podil v rax, zbytek v rdx
    mov rax, rbx       ; a = b
    mov rbx, rdx       ; b = zbytek
    jmp gcd_loop

gcd_done:
    ; vysledek je v rax
    ; odtud stejny jak v add.asm
    mov rcx, 10
    mov rbx, result
    add rbx, 19
    mov byte [rbx], 0

convert_loop:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rbx
    mov [rbx], dl
    test rax, rax
    jnz convert_loop

    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, 5
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    mov rdx, result+20
    sub rdx, rbx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
