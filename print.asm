bits 16
org 100h

section .data
var1: db 'Hello World!', 0ah, 0dh, '$'

section .code
main:
	mov dx, var1
	mov ah, 09
	int 21h
	int 20h