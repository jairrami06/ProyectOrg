.model small
.stack 100h
.data

; Lista de palabras
words db 'brasil$francia$peru$chile$alemania$', 0  

sopa DB 10,13,'BRASILXXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'FRANCIAXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
     
userWord db 19, 0, 19 dup('$')

punteroasopa dw ?
punteroapalabras dw ?
contador db ?
     
; ... puedes agregar más palabras

; Buffer para la palabra del usuario, ajustado para el servicio 0Ah longitud

wordFound db 'Palabra encontrada$'
wordNotFound db 'Palabra no encontrada$'

.code
start:
    ; Inicializar segmento de datos
    mov bx, offset sopa       ; BX apunta al inicio de sopa
    mov ah, 0Eh               ; AH=0Eh para salida de teletipo

print_loop:
    mov al, [bx]              ; Carga el carácter actual en AL
    cmp al, '$'               ; Comprueba si es el carácter de terminación
    je  end_print             ; Si es así, salta al final
    int 10h                   ; Imprime el carácter en pantalla
    inc bx                    ; Incrementa el puntero para apuntar al siguiente carácter
    jmp print_loop            ; Repite el bucle

end_print:
    ; Continúa con el resto de tu programa

    
    
