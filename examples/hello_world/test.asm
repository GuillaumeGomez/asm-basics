;
; asm-basics - Copyright (c) 2014 Gomez Guillaume.
;
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from
; the use of this software.
;
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following restrictions:
;
; 1. The origin of this software must not be misrepresented; you must not claim
;    that you wrote the original software. If you use this software in a product,
;    an acknowledgment in the product documentation would be appreciated but is
;    not required.
;
; 2. Altered source versions must be plainly marked as such, and must not be
;    misrepresented as being the original software.
;
; 3. This notice may not be removed or altered from any source distribution.
;

section .data

message:
	db      'hello world!', 10 ; 10 is '\n' character

section .text

global _start
_start:
	mov     rax, 1 		 ; syscall for write function
	mov     rdi, 1 		 ; standard output
	mov     rsi, message ; we give message as argument
	mov     rdx, 14		 ; length of message
	syscall

	mov     rax, 60      ; call of exit
	xor     rdi, rdi     ; exit status (0)
	syscall