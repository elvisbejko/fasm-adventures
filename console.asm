format ELF executable

segment readable executable

entry start

start:
    ; Dummy arithmetic on rax
    inc     eax
    inc     eax
    dec     eax
    inc     eax

    ; Exit syscall: exit(0)
    mov     eax, 60     ; syscall number for exit
    xor     edi, edi    ; status = 0
    syscall

segment readable writeable
