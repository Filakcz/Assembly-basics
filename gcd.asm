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
    cmp rbx, 0
    je gcd_done
    xor rdx, rdx       ; vynulujeme high cast pred div
    div rbx            ; rax / rbx -> podil v rax, zbytek v rdx
    mov rax, rbx       ; a = b
    mov rbx, rdx       ; b = zbytek
    jmp gcd_loop

gcd_done:
    ; vysledek je v rax

; --- prevod cisla v rax na string ---
    mov rcx, 10
    mov rsi, result
    add rsi, 19
    mov byte [rsi], 0      ; ukoncovaci null

convert_loop:
    xor rdx, rdx
    div rcx                ; rax / 10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz convert_loop

    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, 5
    syscall

    mov rax, 1
    mov rdi, 1
    mov rdx, result+20
    sub rdx, rsi       ; delka stringu
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
