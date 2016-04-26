%macro write 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro read 2
mov eax,3
mov ebx,0
mov ecx,%1
mov edx,%2
int 80h
%endmacro
section .data
msg1 db "Enter n",10
len1 equ $-msg1
msg2 db "greatest is : "
len2 equ $-msg2
msg3 db "smallest is : "
len3 equ $-msg3
msg4 db "enter number : "
len4 equ $-msg4
newln db "",10
len5 equ $-newln
n db 0
section .bss
temp resb 1
temp1 resb 1
section .text
global _start
_start:
write msg1,len1
call readdata
mov ecx,esi
mov edi,esi
l1:
   push esi
   mov esi,0
   call readdata
   mov eax,esi
   pop esi
   push eax
   dec esi
  jnz l1
write msg2,len2

mov esi,edi
mov ecx,edi
pop eax
dec ecx
pop ebx
dec ecx
cmp eax,ebx
jnl check
less:
mov edx,ebx
mov ebx,eax
mov eax,edx

check:
   clc
   cmp ecx,0000
        je here
check1: pop edx
   clc
   cmp eax,edx
 jle move1
   clc
   cmp ebx,edx
 jge move2
   jmp m
  move2:
   mov ebx,edx
   jmp m
  move1:
   mov eax,edx
m:dec ecx
l:jnz check1

here:mov esi,eax
mov edi,ebx
xor ecx,ecx
convert:
  xor edx,edx
  mov ebx,10
  div ebx
  add edx,30h
  push edx
  inc ecx
  cmp eax,0000
  jne convert

dis1:
    pop edx
    push ecx
    mov [temp],edx
    write temp,1
    pop ecx
    dec ecx
    jnz dis1
write newln,len5
write msg3,len3
mov eax,edi

clc
xor ecx,ecx
convert1:
  xor edx,edx
  mov ebx,10
  div ebx
  add edx,30h
  push edx
  inc ecx
  cmp eax,0000
  jne convert1

dis2:
    pop edx
    push ecx
    mov [temp],edx
    write temp,1
    pop ecx
    dec ecx
    jnz dis2
write newln,len5



sys_exit:
  mov eax,1
  mov ebx,0
  int 80h


readdata:
 read temp,1
 mov ecx,[temp]
 cmp ecx,10
 je done
 sub ecx,30h
 mov eax,esi
 mov ebx,10
 mul ebx
 add eax,ecx
 mov esi,eax
 jmp readdata
done:ret
