name Proyecto
org 100h

.model small
.data
msgp db '                     Bienvenido a sopadeletraPOL $'
msgp0 db 10,13,'Escoge una tematica:$'
msgp1 db 10,13,'1.Paises de America y de Europa$'
msgp2 db 10,13,'2.Ciudades del Ecuador$'
msgp3 db 10,13,'3.Paises de Asia y de Africa$'
msgp4 db 10,13,'4.Salir$',10,13
msgp5 db 10,13,'Opcion seleccionada: $'

msgs1 db 'Tematica seleccionada: Paises de America y Europa$'
msgs2 db 'Tematica seleccionada: Ciudades del Ecuador$'
msgs3 db 'Tematica seleccionada: Paises de Asia y de Africa$'

msgo1 db 10,13,'1.Opcion 1$'
msgo2 db 10,13,'2.Opcion 2$'
msgo3 db 10,13,'3.Atras$'

msgj1 db 10,13,'Palabra (0 para rendirse): $'

msgf1 db '               Juego Terminado $'
msgf2 db 10,13,'Felicidades!!! Ha adivinado las 5 palabras$'
msgf3 db 10,13,'Se ha rendido$'

; Lista de palabras
words db 'brasil$francia$peru$chile$alemania$', 0
wordEnd db 0
punteroasopa dw ?
punteroapalabras dw ?
contador db ?

; Buffer para la palabra del usuario, ajustado para el servicio 0Ah
userWord db 19, 0, 19 dup('$') ; Capacidad para 19 caracteres + longitud

wordFound db 'Palabra encontrada$'
wordNotFound db 'Palabra no encontrada$'

salto db 10,13,'$'
msg1.1 db ''     
.code
.start


; Inicio del programa
inicio:
    call clearscreen 
    mov ah, 09h
    lea dx, msgp
    int 21h
    lea dx, msgp0
    int 21h
    lea dx, msgp1
    int 21h
    lea dx, msgp2
    int 21h
    lea dx, msgp3
    int 21h
    lea dx, msgp4
    int 21h
    lea dx, msgp5
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h
    
    cmp al, 1
    je opcion1
    cmp al, 2
    je opcion2
    cmp al, 3
    je opcion3
    cmp al, 4
    je final
    jne inicio

opcion1:
    call clearscreen
    mov ah, 09h
    lea dx, msgs1
    int 21h
    lea dx, msgo1
    int 21h
    lea dx, msgo2
    int 21h
    lea dx, msgo3
    int 21h
    lea dx, msgp5
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h
    
    cmp al, 1
    je printsopa1
    cmp al, 2 
    je printsopa2
    cmp al, 3
    je inicio 
    
opcion2:
    mov ah, 09h
    lea dx, msgs2
    int 21h
    lea dx, msgo1
    int 21h
    lea dx, msgo2
    int 21h
    lea dx, msgo3
    int 21h
    lea dx, msgp5
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h  
    

opcion3:   
    mov ah, 01h
    int 21h
    sub al, 30h
    lea dx, salto
    mov ah, 09h
    int 21h
    sub al, 30h
    
    cmp al, 1
    je printsopa1
    cmp al, 2
    je printsopa2
    
printsopa1:          
sopa1 DB 10,13,'BRASILXXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'FRANCIAXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov punteroasopa, offset sopa1
    mov punteroapalabras, offset words
    call imprimir
    jmp principal
    
printsopa2:   
sopa2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov dx, offset sopa2 ; Puntero al inicio de la sopa de letras
    jmp imprimir
  
imprimir:    
    mov dx, punteroasopa ; Puntero al inicio de la sopa de letras
    mov si, punteroapalabras
    call clearscreen 
    mov ah, 09h          ; imprimir cadena
    int 21h              ; Interrupcion del DOS para imprimir
    ret                                                  
    
principal: 
    cmp contador, 5
    jz final
    mov ah, 09h
    lea dx, msgj1
    int 21h
    lea dx, salto
    int 21h
    mov dx, offset userWord
    mov ah, 0Ah
    int 21h
    jmp verificar

verificar:    
    mov al, [userWord + 1] ; Carga el número de caracteres ingresados
    cmp al, 1              ; Compara si solo se ingresó 1 carácter
    jne NextWord           ; Salta a la etiqueta 'not_zero' si hay más de 1 carácter

    mov al, [userWord + 2] ; Carga el primer (y único) carácter ingresado
    cmp al, '0'            ; Compara con el carácter '0'
    je final             ; Salta a 'is_zero' si el carácter es '0' 

NextWord:
    call CompareWords
    jc PrintMessageFound  ; Si se encontró la palabra, salta a PrintWordFound

    ; Buscar el siguiente '$' para pasar a la siguiente palabra
    call FindNextWord
    cmp al, 0          ; Comprueba si hemos llegado al final de la lista
    jne NextWord       ; Si no es el final, pasa a la siguiente palabra

    ; Si no se encontró la palabra
    jmp PrintMessageNotFound

FindNextWord:
    mov al, [si]
    inc si
    cmp al, '$'
    je NextWord
    cmp al, 0
    jne FindNextWord
    ret

CompareWords:
    push si            ; Guarda el valor original de SI
    push di            ; Guarda el valor original de DI
    push cx            ; Guarda el valor original de CX

    mov di, offset userWord + 2 ; DI apunta al inicio de userWord
    mov cx, 20                  ; Longitud máxima de userWord

CompareLoop:
    mov al, [si]                ; Carga un carácter de la palabra de la lista
    mov ah, [di]                ; Carga un carácter de userWord

    cmp al, '$'                 ; Comprueba si es el final de la palabra en la lista
    je CheckEndOfUserWord       ; Si es el final, verifica el final de userWord

    cmp ah, 0Dh                 ; Comprueba si es el final de userWord
    je NotEqual                 ; Si es el final, las palabras no son iguales

    cmp al, ah                  ; Compara los dos caracteres
    jne NotEqual                ; Si son diferentes, salta a NotEqual

    inc si                      ; Incrementa SI para apuntar al siguiente carácter
    inc di                      ; Incrementa DI para apuntar al siguiente carácter
    loop CompareLoop            ; Repite el bucle para el siguiente carácter

CheckEndOfUserWord:
    inc bh
    cmp ah, 0Dh                 ; Comprueba si userWord también terminó
    je Equal                    ; Si es el final, las palabras son iguales

NotEqual:
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    clc                         ; Limpia el flag de carry
    ret                         ; Retorna sin encontrar coincidencia

Equal:
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    stc                         ; Establece el flag de carry para indicar coincidencia
    ret                         ; Retorna con coincidencia encontrada
                 
PrintMessageFound:
    add contador, 1
    call clearscreen
    call imprimir
    jmp principal
    
                 
PrintMessageNotFound:
    call clearscreen
    call imprimir
    ; Imprimir el mensaje en DX
    mov dx, offset wordNotFound
    mov ah, 09h
    int 21h
    jmp principal    
    
final:
    call clearscreen
    mov ah, 09h
    lea dx, msgf1
    int 21h
    cmp contador, 5
    je gano
    jne perdio


gano:
    lea dx, msgf2
    int 21h
    ; Terminar programa
    mov ax, 4C00h
    int 21h
       
perdio:
    lea dx, msgf3
    int 21h
    ; Terminar programa
    mov ax, 4C00h
    int 21h           
    
    
clearscreen:
    mov ah, 0  ; function 0 of INT 10h - set video mode
    mov al, 3  ; video mode 3, which is text mode 80x25
    int 10h    ; call interrupt 10h; Clear screen
    mov ah, 0  ; function 0 of INT 10h - set video mode
    mov al, 3  ; video mode 3, which is text mode 80x25
    int 10h  
    ret  ; call interrupt 10h    