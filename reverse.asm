format ELF64 executable 3
entry start

segment readable executable

; syscall numbers
SYS_READ  equ 0
SYS_WRITE equ 1
SYS_EXIT  equ 60

start:
    mov rdi, 0                  ; stdin fd
    mov rsi, numbers            ; buffer to store input numbers
    mov rdx, 16                 ; read max 16 bytes (4 numbers with spaces/newlines)
    mov rax, SYS_READ
    syscall

    ; print to buffer as-is
    mov rdi, 1                  ; stdout fd
    mov rsi, numbers
    mov rdx, rax                ; number of bytes read
    mov rax, SYS_WRITE
    syscall

    ; exit
    xor rdi, rdi
    mov rax, SYS_EXIT
    syscall

segment readable writeable
  numbers      rb 16
  keep_nums    dd 5 dup (0)     ; works
