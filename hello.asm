section .data ; sekce na ukladani dat
    msg db "Hello world!", 10  ; msg = define byte textu + \n
    len equ $ - msg              ; len zpravy = $ (aktualni adresa) - zprava
    ; msg delka je napr 14
    ; pokud zacina msg na adrese 1000 tak $ je na adrese 1014

section .text ; kod, ktery se spousti, instrukce pro CPU
    global _start ; viditelny startovni bod

_start: ; start
    ; write(1, msg, len) - "funkce"
    mov rax, 1        ; syscall cislo 1 = write
    mov rdi, 1        ; 1 = stdout (standarni output)
    mov rsi, msg      ; ukazatel na text zpravy
    mov rdx, len      ; delka zpravy
    syscall           ; system call

    ; exit(0)
    mov rax, 60       ; syscall cislo 60 = exit
    xor rdi, rdi       ; kod k exitu
    ; tohle je o 5 bajtu lepsi nez mov rdi, 0
    syscall
