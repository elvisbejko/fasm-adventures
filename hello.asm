; fasm demonstration of writing simple ELF executable

format ELF executable 3

segment readable executable

entry start    ; in the original file this was located before the segment. You should put it here instead

start:
  mov     eax,4
  mov     ebx,1
  mov     ecx,msg
  mov     edx,msg_size
  int     0x80

  mov     eax,1
  xor     ebx,ebx
  int     0x80

segment readable writeable

msg db "Hello world!",0xA
msg_size = $-msg
