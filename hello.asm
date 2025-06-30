; https://board.flatassembler.net/topic.php?t=8506

format ELF executable 3     ; 32bit ELF executable

segment readable executable

entry start               ; You should put it here instead

start:
  mov    eax,4            ; syscall number for sys_write
  mov    ebx,1            ; fd 1 (stdout)
  mov    ecx,msg          ; pointer to msg
  mov    edx,msg_size     ; msg length
  int    0x80             ; interrupt to invoke syscall TODO

  mov    eax,1            ; syscall number for sys_exit
  xor    ebx,ebx          ; exit code 0
  int    0x80             ; perform syscall

segment readable writeable

msg db "Hello world!",0xA
msg_size = $-msg
