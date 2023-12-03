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

palabrasAdiv db 0, 0, 0, 0, 0 

finDePalabra db 0
pointersopa dw ?
pointerPalabras dw ?
contador db ?
indicePalabra dw ?

; Buffer para la palabra del usuario, ajustado para el servicio 0Ah
palabraUsuario db 19, 0, 19 dup('$') ; Capacidad para 19 caracteres + longitud

msgFound db 'Palabra encontrada$'
msgNotFound db 'Palabra no encontrada$'
msgGuessed db 'Palabra ya adivinada$'

salto db 10,13,'$'
msg1.1 db ''     
.code
.start


; menu_inicio del programa
menu_inicio:
    call limpiarPantalla 
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
    jne menu_inicio

opcion1:
    call limpiarPantalla
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
    je menu_inicio 
    
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
    je menu_inicio   
    

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
    je menu_inicio  
    
printsopa1.1:       
    sopa1_1 DB 10,13,'I F H B R A S I L C F S M',0Dh,0Ah, 'V I A E K B P C I U M N B',0Dh,0Ah
    DB 'L P O I Q S E H A Q W T E',0Dh,0Ah,'A F R T Q W R A S D J K L',0Dh,0Ah
    DB 'A C R N T Y U Z X C V B U',0Dh,0Ah,'X Q Z A I A M O N X Z B N',0Dh,0Ah
    DB 'X C B V N H I L A P L Q S',0Dh,0Ah,'Z P O L S C Q J A A N J H',0Dh,0Ah
    DB 'Q O L S Z M I N B T R E W',0Dh,0Ah,'A L E M A N I A I E K S N',0Dh,0Ah
    DB 'X C A S E W O J K N M D A',0Dh,0Ah,'E I Q K S E L I H C S J U',0Dh,0Ah
    DB 'Q U W K S M M N X B H J O',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_1
    mov pointerPalabras, offset words1_1
    call imprimirSopa
    jmp pedirPalabra
    
printsopa1.2:  
sopa1_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_2
    mov pointerPalabras, offset words1_2
    call imprimirSopa
    jmp pedirPalabra
    
printsopa2.1:   
sopa2_1 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_1
    mov pointerPalabras, offset words2_2
    call imprimirSopa
    jmp pedirPalabra
    
printsopa2.2:   
sopa2_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_2
    mov pointerPalabras, offset words2_2
    call imprimirSopa
    jmp pedirPalabra  
    
printsopa3.1:   
sopa3_1 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_1
    mov pointerPalabras, offset words3_1
    call imprimirSopa
    jmp pedirPalabra
  
printsopa3.2:   
sopa3_2 DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_2
    mov pointerPalabras, offset words3_2
    call imprimirSopa
    jmp pedirPalabra
  
imprimirSopa:    
    mov dx, pointersopa ; Puntero al menu_inicio de la sopa de letras
    mov si, pointerPalabras
    call limpiarPantalla 
    mov ah, 09h          ; imprimirSopa cadena
    int 21h              ; Interrupcion del DOS para imprimirSopa
    ret                                                  
    
pedirPalabra: 
    cmp contador, 5
    jz final
    mov ah, 09h
    lea dx, msgj1
    int 21h
    lea dx, salto
    int 21h
    lea dx, palabraUsuario
    mov ah, 0Ah
    int 21h
    jmp convertirAMinuscula

convertirAMinuscula:
    mov indicePalabra, 0
    lea bx, [palabraUsuario + 2]      ; Comienza en el tercer byte de palabraUsuario
    mov cl, [palabraUsuario + 1]      ; Carga el número de caracteres ingresados en CL
    or cl, cl                   ; Verifica si CL es 0 (ningún carácter ingresado)
    jz verificarPalabra                ; Si es 0, salta directamente a verificarPalabra

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

    jmp verificarPalabra               ; Salta a verificarPalabra después de convertir

verificarPalabra:    
    mov al, [palabraUsuario + 1]      ; Carga el número de caracteres ingresados
    cmp al, 1                   ; Compara si solo se ingresó 1 carácter
    jne siguientePalabra                ; Salta a la etiqueta 'siguientePalabra' si hay más de 1 carácter

    mov al, [palabraUsuario + 2]      ; Carga el primer (y único) carácter ingresado
    cmp al, '0'                 ; Compara con el carácter '0'
    je final                    ; Salta a final si es '0'
    
siguientePalabra:
    add indicePalabra, 1
    call compararPalabras
    jc verificarAcierto  ; Si se encontró la palabra, salta a PrintmsgFound

    ; Buscar el siguiente '$' para pasar a la siguiente palabra
    call encontrarSigPalabra
    cmp al, 0          ; Comprueba si hemos llegado al final de la lista
    jne siguientePalabra       ; Si no es el final, pasa a la siguiente palabra

    ; Si no se encontró la palabra
    jmp palNoEncontrada
                             
verificarAcierto:    
    sub indicePalabra, 1
    mov si, indicePalabra
    ; Verifica si el valor en la posición correspondiente es 0
    mov al, [palabrasAdiv + si]  ; Carga el valor actual en la posición 'si' del arreglo
    cmp al, 0                    ; Compara si el valor es 0
    jne palYaAdivinada           ; Si no es 0, salta a la etiqueta 'palYaAdivinada'

    ; Cambia el valor a 1 si el valor anterior era 0
    mov byte [palabrasAdiv + si], 1
    jmp palabrasIguales                             
                             
                             
encontrarSigPalabra:
    mov al, [si]
    inc si
    cmp al, '$'
    je siguientePalabra
    cmp al, 0
    jne encontrarSigPalabra
    ret

compararPalabras:
    push si            ; Guarda el valor original de SI
    push di            ; Guarda el valor original de DI
    push cx            ; Guarda el valor original de CX

    mov di, offset palabraUsuario + 2 ; DI apunta al menu_inicio de palabraUsuario
    mov cx, 20                  ; Longitud máxima de palabraUsuario 
    mov bx, si                   ; BX guarda la posición inicial de la palabra en la lista


loopComparar:
    mov al, [si]                ; Carga un carácter de la palabra de la lista
    mov ah, [di]                ; Carga un carácter de palabraUsuario

    cmp al, '$'                 ; Comprueba si es el final de la palabra en la lista
    je CheckFinPalabraUsuario       ; Si es el final, verifica el final de palabraUsuario

    cmp ah, 0Dh                 ; Comprueba si es el final de palabraUsuario
    je diferentes                 ; Si es el final, las palabras no son iguales

    cmp al, ah                  ; Compara los dos caracteres
    jne diferentes                ; Si son diferentes, salta a diferentes

    inc si                      ; Incrementa SI para apuntar al siguiente carácter
    inc di                      ; Incrementa DI para apuntar al siguiente carácter
    loop loopComparar            ; Repite el bucle para el siguiente carácter

CheckFinPalabraUsuario:
    inc bh
    cmp ah, 0Dh                 ; Comprueba si palabraUsuario también terminó
    je iguales                    ; Si es el final, las palabras son iguales

diferentes:
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    clc                         ; Limpia el flag de carry
    ret                         ; Retorna sin encontrar coincidencia

iguales: 
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    stc                         ; Establece el flag de carry para indicar coincidencia
    ret                         ; Retorna con coincidencia encontrada
                 
palabrasIguales:
    add contador, 1
    call limpiarPantalla
    call imprimirSopa
    jmp pedirPalabra
    
                 
palNoEncontrada:
    call limpiarPantalla
    call imprimirSopa
    ; imprimirSopa el mensaje en DX
    mov dx, offset msgNotFound
    mov ah, 09h
    int 21h
    jmp pedirPalabra    
                   
 
palYaAdivinada:
    call limpiarPantalla
    call imprimirSopa
    mov dx, offset msgGuessed
    mov ah, 09h
    int 21h
    jmp pedirPalabra  
     
 
final:
    call limpiarPantalla
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
    
    
limpiarPantalla:
    mov ah, 0  ; function 0 of INT 10h - set video mode
    mov al, 3  ; video mode 3, which is text mode 80x25
    int 10h    ; call interrupt 10h; Clear screen
    mov ah, 0  ; function 0 of INT 10h - set video mode
    mov al, 3  ; video mode 3, which is text mode 80x25
    int 10h  
    ret  ; call interrupt 10h
