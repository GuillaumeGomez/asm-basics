section .data

message:
	db      'hello world!', 10

section .text

global _start
_start:
	mov     rax, 1 		 ; syscal for write function
	mov     rdi, 1 		 ; standard output
	mov     rsi, message ; we give message as argument
	mov     rdx, 14		 ; length of message
	syscall

	mov     rax, 3ch ; call of exit
	xor     rdi, rdi ; exit status (0)
	syscall