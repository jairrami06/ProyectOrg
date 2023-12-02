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

msgs1 db 'Tematica : Paises de America y Europa$'
msgs2 db 'Tematica : Ciudades del Ecuador$'
msgs3 db 'Tematica : Paises de Asia y de Africa$'

msgo1 db 10,13,'1.Facil$'
msgo2 db 10,13,'2.Dificil$'
msgo3 db 10,13,'3.Atras$'

msgj1 db 10,13,'Palabra (0 para rendirse): $'

msgf1 db '               Juego Terminado $'
msgf2 db 10,13,'Felicidades!!! Ha adivinado las 5 palabras$'
msgf3 db 10,13,'Muchas gracias por jugar$'

; Lista de palabras
words1_1 db 'brasil$francia$peru$chile$alemania$', 0
words1_2 db 'brasil$francia$peru$chile$alemania$', 0
words2_1 db 'brasil$francia$peru$chile$alemania$', 0
words2_2 db 'brasil$francia$peru$chile$alemania$', 0
words3_1 db 'brasil$francia$peru$chile$alemania$', 0
words3_2 db 'brasil$francia$peru$chile$alemania$', 0

wordEnd db 0
pointersopa dw ?
pointerwords dw ?
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
    je printsopa1.1
    cmp al, 2 
    je printsopa1.2
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
    
    cmp al, 1
    je printsopa2.1
    cmp al, 2 
    je printsopa2.2
    cmp al, 3
    je inicio   
    

opcion3:   
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
    
    cmp al, 1
    je printsopa3.1
    cmp al, 2 
    je printsopa3.2
    cmp al, 3
    je inicio  
    
printsopa1.1:       
    sopa1_1 DB 10,13,'I F H B R A S I L C F S M',0Dh,0Ah, 'V I A E K B P C I U M N B',0Dh,0Ah
    DB 'L P O I Q S E H A Q W T E',0Dh,0Ah,'A F R T Q W R A S D J K L',0Dh,0Ah
    DB 'A C R N T Y U Z X C V B U',0Dh,0Ah,'X Q Z A I A M O N X Z B N',0Dh,0Ah
    DB 'X C B V N H I L A P L Q S',0Dh,0Ah,'Z P O L S C Q J A A N J H',0Dh,0Ah
    DB 'Q O L S Z M I N B T R E W',0Dh,0Ah,'A L E M A N I A I E K S N',0Dh,0Ah
    DB 'X C A S E W O J K N M D A',0Dh,0Ah,'E I Q K S E L I H C S J U',0Dh,0Ah
    DB 'Q U W K S M M N X B H J O',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_1
    mov pointerwords, offset words1_1
    call imprimir
    jmp principal
    
printsopa1.2:  
sopa1_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_2
    mov pointerwords, offset words1_2
    call imprimir
    jmp principal
    
printsopa2.1:
    mov ah, 09h
    lea dx, msgs2
    int 21h    
sopa2_1 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_1
    mov pointerwords, offset words2_2
    call imprimir
    jmp principal
    
printsopa2.2:   
sopa2_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_2
    mov pointerwords, offset words2_2
    call imprimir
    jmp principal  
    
printsopa3.1:   
sopa3_1 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_1
    mov pointerwords, offset words3_1
    call imprimir
    jmp principal
  
printsopa3.2:   
sopa3_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_2
    mov pointerwords, offset words3_2
    call imprimir
    jmp principal
  
imprimir:    
    mov dx, pointersopa ; Puntero al inicio de la sopa de letras
    mov si, pointerwords
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
    lea dx, userWord
    mov ah, 0Ah
    int 21h
    jmp convertir_a_minusculas

convertir_a_minusculas:
    lea bx, [userWord + 2]      ; Comienza en el tercer byte de userWord
    mov cl, [userWord + 1]      ; Carga el número de caracteres ingresados en CL
    or cl, cl                   ; Verifica si CL es 0 (ningún carácter ingresado)
    jz verificar                ; Si es 0, salta directamente a verificar

    convertir_loop:
        mov al, [bx]            ; Carga el carácter actual en AL
        cmp al, 'A'             ; Comprueba si es una letra mayúscula
        jb siguiente_caracter
        cmp al, 'Z'
        ja siguiente_caracter
        add al, 32              ; Convierte la letra a minúscula
        mov [bx], al            ; Guarda la letra convertida

    siguiente_caracter:
        inc bx                  ; Avanza al siguiente carácter
        dec cl                  ; Decrementa el contador de caracteres
        jnz convertir_loop      ; Continúa si aún hay caracteres por convertir

    jmp verificar               ; Salta a verificar después de convertir

verificar:    
    mov al, [userWord + 1]      ; Carga el número de caracteres ingresados
    cmp al, 1                   ; Compara si solo se ingresó 1 carácter
    jne NextWord                ; Salta a la etiqueta 'NextWord' si hay más de 1 carácter

    mov al, [userWord + 2]      ; Carga el primer (y único) carácter ingresado
    cmp al, '0'                 ; Compara con el carácter '0'
    je final                    ; Salta a final si es '0'
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
    mov bx, si                   ; BX guarda la posición inicial de la palabra en la lista


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