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

; since this program use C code, it has to be compiled like this :
; nasm -felf64 examples/entry_character_count/test.asm -o bin/test.o
; gcc bin/test.o -o bin/entry_character_count <- this line change

extern printf ; we declare printf to use it later
global main   ; like that we can use printf in our program


section .data

message:  db      'Enter something :', 10, '> '
test:     db      'Number of characters entered : %d', 10, 0
backline: db      10 ; equ means its like a constant, something like "#define backline 10" in C

section .bss
char:     resb    1 ; we declare an unintialized value of 1 byte


section .text

main:
    mov     rax, 1       ; syscall for write function
    mov     rdi, 1       ; standard output
    mov     rsi, message ; we give message as argument
    mov     rdx, 20      ; length of message
    syscall

    mov r8, 0         ; we initialize our character counter to 0

read_loop:
    inc r8            ; we add 1 character each loop
    mov rax, 0        ; 0 is the read syscall
    mov rdi, 0        ; 0 is the standard input
    mov rsi, char     ; set the address
    mov rdx, 1        ; number of character we read
    syscall

    cmp rax, 0        ; if read syscall returns 0, there is a problem
    je exit           ; so we quit
    mov r9, [char]    ; to get the value of char, we use the [] and we move this value to another register
    cmp r9, 10        ; we compare 10 (which is the value of backline) to the entered character
    jne read_loop     ; if it's not a backline, then we read the next one
    sub r8, 1         ; otherwise, we subtract 1 from r8 because we don't count backline as a character in this program

print:
    mov rax, r8       ; we move r8 to rax in order to print it
    push rax          ; caller-save register
    push rcx          ; caller-save register

    mov rdi, test     ; we put the format string
    mov rsi, rax      ; then the first argument
    xor rax, rax      ; since it's a va-arg, we have to finish it with 0
    call printf

    pop rcx           ; restore caller-save register
    pop rax           ; restore caller-save register

exit:
    mov     rax, 60  ; call of exit
    mov     rdi, 0   ; exit status(0)
    syscall