section .data
    num1 dq 150                ; define quadword (64bit) prvni cislo
    num2 dq 600                  ; druhe cislo
    result_msg db "Vysledek: ",0
    newline db 10              ; \n

section .bss ; buffer - rezervace mista
    result resb 20             ; buffer pro cislo (20 bajtu)

section .text
    global _start

_start:
    mov rax, [num1]            ; [] = pristup do pameti (data)
    add rax, [num2]            ; rax = num1 + num2
    ; musime prevest z binarniho na desitkovou

    ; prevod cisla v rax na string (do bufferu result)
    mov rcx, 10                ; deleni 10 (soustavou)
    mov rbx, result            ; adresa zacatku bufferu
    add rbx, 19                ; zacneme od konce bufferu
    mov byte [rbx], 0          ; ukoncovaci null na konec

convert_loop:
    xor rdx, rdx             ; vynuluj zbytek
    div rcx                    ; rax / 10, zbytek v rdx
    ; podil do rax, zbytek do rdx
    add dl, '0'                ; zbytek prevod cislice na ASCII
    dec rbx                    ; posun v bufferu o 1 doleva
    mov [rbx], dl              ; uloz znak do bufferu
    test rax, rax              ; jestli rax = 0
    jnz convert_loop           ; pokud ne, tak opakuj

    ; tisk "Vysledek:"
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, 10
    syscall

    ; vytiskni cislo (retezec od rbx po konec bufferu)
    mov rax, 1                 ; syscall write
    mov rdi, 1                 ; stdout
    mov rsi, rbx               ; adresa retezce
    mov rdx, result+20         ; konec bufferu
    syscall

    ; \n
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
