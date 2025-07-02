; Example of flat binary. 
; Compiles to flat-inc.bin not an executable

use32     ; 32bit code setting, 
          ; if omitted opcode is different

inc     eax
inc     eax
inc     eax
inc     eax
inc     eax
dec     eax
xchg    eax,eax    ; rax won't work in 32bit mode
xchg    eax,eax    ; rax won't work in 32bit mode
nop
