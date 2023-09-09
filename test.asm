; 1100011   1111111   1111111   0001111   1100011
; 1010101   0001000   1000000   0110000   1100011
; 1001001   0001000   1111111   1100000   1111111     1's represent $ and 0's represent ' '
; 1000001   0001000   1000000   0110000   1100011
; 1100011   0001000   1111111   0001111   1100011

org 0x100

call main

section  .data
row1: db '1100011001111111001111111000001111001100011$'       ; '$' = ' ' on console
row2: db '1010101000001000001000000000110000001100011$'
row3: db '1001001000001000001111111001100000001111111$'
row4: db '1000001000001000001000000000110000001100011$'
row5: db '1100011000001000001111111000001111001100011$'

newLine: db '', 0x0a, 0x0d, '$'

section .code
main:
    call screen
    call cursor

    xor ax,ax
    xor cx,cx
    xor dx,dx
    xor bx,bx
    mov bx, row1
    mov si, bx
    mov cl, 0
    call Loop_

    xor ax,ax
    xor cx,cx
    xor dx,dx
    xor bx,bx
    mov bx, row2
    mov si, bx
    mov cl, 0
    call Loop_

    xor ax,ax
    xor cx,cx
    xor dx,dx
    xor bx,bx
    mov bx, row3
    mov si, bx
    mov cl, 0
    call Loop_

    xor ax,ax
    xor cx,cx
    xor dx,dx
    xor bx,bx
    mov bx, row4
    mov si, bx
    mov cl, 0
    call Loop_

    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    mov bx, row5
    mov si, bx
    mov cl, 0
    call Loop_

    int 0x20    ; Exit program

cursor:
    mov ah, 02
    mov bh, 00
    mov dx, 0x0a00
    int 0x10
    ret

screen:
    mov ax  ,0x0600
    mov cx  ,0000
    mov dx  ,0x184F
    mov bh  ,00011110b  ; yellow on blue background
                        ; blue(0001b) yellow (11110b)
    int 0x10
    ret

; Now to write the algorithm to print

Loop_:
    mov al  ,'1'
    cmp [si],al
    je printDollar   ; jump to print Dollar if equal
    mov al  ,'0'
    cmp [si], al
    je printSpace    ; jump to print space if equal
    mov al  ,'$'
    call nextLine    ; skip line 
    inc si
    ret

printDollar:
    mov ah  ,02
    mov dl  ,36      ; ASCII for '$' is 36
    int 0x21
    inc si
    jmp Loop_

printSpace:
    mov ah  ,02
    mov dl  ,' '
    int 0x21
    inc si
    jmp Loop_

nextLine:
    mov ax, newLine
    mov dx, ax
    mov ah, 09
    int 0x21
    ret