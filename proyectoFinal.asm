name Proyecto
org 100h

;Variables del proyecto
.model small
.data
;Mensajes a mostrar en el menu
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

msgFound db 'Palabra encontrada$'
msgNotFound db 'Palabra no encontrada$'
msgGuessed db 'Palabra ya adivinada$'

;Lista de palabras por matriz y en paralelo su posx,posy,orientacion,longitud 

                     ;brasil       ;peru            ;francia      ;alemania	   ;chile
datos_palabras1_1 DB 1 , 3 , 1 , 6 , 3 , 6 , 2 , 4 , 4 , 1 , 3 ,7 , 2, 5 , 1 ,8 , 4 , 8  ,1 ,5

                     ;portugal       ;CUBA          ;haiti          ;SUIZA	   ;romania
datos_palabras1_2 DB 1 , 0 , 1 , 8 , 2 , 2 , 3 , 4 , 4 , 2 , 3 ,5 , 4, 7 , 1 ,5 , 9 , 0  ,1 ,7  

                     ;puyo         ;quito           ;loja           ;tena	    ;manta
datos_palabras2_1 DB 1 , 12 , 2 , 4 , 1, 0 , 3 , 5 , 5 , 0 , 1 ,4 , 6 , 8  ,1 ,5 , 1 , 2  ,1 ,5  

                     ;duran         ;daule          ;chone           ;guayaquil    ;chone
datos_palabras2_2 DB 6 , 0 , 3 , 5 , 4 , 5 , 1 , 5 , 1 , 12 , 2 ,5 , 1, 2 , 1 ,9 , 6 , 8  ,1 ,5  

                    ;iran          ;irak           ;ghana           ;mali	    ;china
datos_palabras3_1 DB 6 , 9  ,1 ,4  , 2 , 9 , 1 , 4 , 1 , 4 , 1 ,5 , 1, 0 , 2 ,4 , 2 , 2  ,3 ,5

                    ;india         ;niger          ;yemen           ;laos        ;taiwan
datos_palabras3_2 DB 1 , 0 , 3 , 5 , 1 , 8 , 1 , 5 , 2 , 12 , 2 ,5 , 6, 8 , 1 ,4 , 4 , 5  ,1 ,6     


words1_1 db 'brasil$peru$francia$alemania$chile$', 0  

words1_2 db 'portugal$cuba$argentina$uruguay$rumania$', 0

words2_1 db 'puyo$quito$loja$tena$manta$', 0

words2_2 db 'duran$daule$chone$guayaquil$macas$', 0

words3_1 db 'iran$irak$ghana$mali$china$', 0

words3_2 db 'india$niger$yemen$laos$taiwan$', 0
 
                             
;Variables para resaltar                             
fila DB 0
columna DB 0  
orientacion DB 0   
longitud DB 0                             
                             
;Variable para saber si palabra fue adivinada                             
palabrasAdiv db 0, 0, 0, 0, 0 

;variables para punteros y buscar palabra en lista
finDePalabra db 0
pointersopa dw ?
pointerPalabras dw ?
pointerDatosPalabras dw ?
contador db ?
indicePalabra dw ?

;Buffer para la palabra del usuario
palabraUsuario db 19, 0, 19 dup('$') ; Capacidad para 19 caracteres + longitud

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

;menu desplegado al seleccionar Paises de America y Europa
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

;menu desplegado al seleccionar Ciudades del Ecuador    
opcion2:
    call limpiarPantalla
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
    
;menu desplegado al seleccionar Paises de Asia y Africa
opcion3:
    call limpiarPantalla   
    mov ah, 09h
    lea dx, msgs3
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

;asignacion de punteros a la sopa seleccionada y sus palabras respectivas 
 
;coloca los punteros en la sopa 1 de la opcion 1    
printsopa1.1:       
    sopa1_1 DB 10,13,'IFHBRASILCFSM',0Dh, 0Ah,'VIAEKALEMANIA',0Dh,0Ah
            DB 'LPOIQSPHAQWTE',0Dh,0Ah, 'AFRTQWEACHILE',0Dh,0Ah
            DB 'ACRNTYRZXCVCU',0Dh,0Ah, 'XQZAIAUONXZBN',0Dh,0Ah
            DB 'XCBVNHILAPLQS',0Dh,0Ah, 'ZPOLSCQJAANJH',0Dh,0Ah
            DB 'QOLSZMINBTREW',0Dh,0Ah, 'ASEJQEIAIEKSN',0Dh,0Ah
            DB 'XCASEWOJKNMDA',0Dh,0Ah, 'EIQKSCXILECSJ',0Dh,0Ah
            DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_1
    mov pointerPalabras, offset words1_1
    mov pointerDatosPalabras, offset datos_palabras1_1
    call imprimirSopa
    jmp pedirPalabra

;coloca los punteros en la sopa 2 de la opcion 1     
printsopa1.2:  
    sopa1_2 DB 10,13, 'PORTUGALLCFAM',0Dh,0Ah,'VICEKBPCIUMRB',0Dh,0Ah
                DB 'LPOUQSEHAQWGE',0Dh,0Ah,'AFHTBWRASDJEL',0Dh,0Ah
                DB 'ACUATAUSUIZAU',0Dh,0Ah,'XQZAIADONXZTN',0Dh,0Ah
                DB 'XCBVNTIOAPLIS',0Dh,0Ah,'ZPOLSCIJRANNH',0Dh,0Ah
                DB 'ROMANIANBTRAW',0Dh,0Ah,'ALXLSSIAIEKSN',0Dh,0Ah
                DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSCHILECSJ',0Dh,0Ah
                DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa1_2
    mov pointerPalabras, offset words1_2
    mov pointerDatosPalabras, offset datos_palabras1_2
    call imprimirSopa
    jmp pedirPalabra

;coloca los punteros en la sopa 1 de la opcion 2     
printsopa2.1:   
    sopa2_1 DB 10,13, 'QMMANTAAQUILP',0Dh,0Ah,'DUQEKBPCIUMRU',0Dh,0Ah
                DB 'JUIUQSEHAQWGY',0Dh,0Ah,'AFRTIDAULEJEO',0Dh,0Ah
                DB 'LOJAOAUSUIZAE',0Dh,0Ah,'DUZAIAOOMTENA',0Dh,0Ah
                DB 'XUBVNHIOAPLIS',0Dh,0Ah,'ZPRLSCQJRANNH',0Dh,0Ah
                DB 'ROMANIANBTRAW',0Dh,0Ah,'ALEMNNIAIEKSN',0Dh,0Ah
                DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSCHILECSJ',0Dh,0Ah
                DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_1
    mov pointerPalabras, offset words2_1
    mov pointerDatosPalabras, offset datos_palabras2_1
    call imprimirSopa
    jmp pedirPalabra

;coloca los punteros en la sopa 2 de la opcion 2     
printsopa2.2:   
    sopa2_2 DB 10,13, 'LOGUAYAQUILPC',0Dh,0Ah,'DIQEKBPCIUMRH',0Dh,0Ah
                DB 'JUOUQSEHAQWGO',0Dh,0Ah,'AFRTIDAULEJEN',0Dh,0Ah
                DB 'ACTENAUSUIZAE',0Dh,0Ah,'DUZAIAOOMACAS',0Dh,0Ah
                DB 'XUBVNHIOAPLIS',0Dh,0Ah,'ZPRLSCQJRANNH',0Dh,0Ah
                DB 'ROMANIANBTRAW',0Dh,0Ah,'ALEMNNIAIEKSN',0Dh,0Ah
                DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSCHILECSJ',0Dh,0Ah
                DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa2_2
    mov pointerPalabras, offset words2_2
    mov pointerDatosPalabras, offset datos_palabras2_2
    call imprimirSopa
    jmp pedirPalabra  

;coloca los punteros en la sopa 1 de la opcion 3     
printsopa3.1:   
    sopa3_1 DB 10,13, 'MORXGHANAPXYO',0Dh,0Ah,'AICEKBPCIIRAK',0Dh,0Ah
                DB 'LPOHQSEHAQWGO',0Dh,0Ah,'IFRTIWRASDJEJ',0Dh,0Ah
                DB 'ACtenNUSUIZAA',0Dh,0Ah,'XQZAIAAOmIRAN',0Dh,0Ah
                DB 'XCBVNHIOAPLIS',0Dh,0Ah,'ZPOLSCQJRANNH',0Dh,0Ah
                DB 'ROMANIANBTRAW',0Dh,0Ah,'ALEMANIAIEKSN',0Dh,0Ah
                DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSCHILECSJ',0Dh,0Ah
                DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_1
    mov pointerPalabras, offset words3_1
    mov pointerDatosPalabras, offset datos_palabras3_1
    call imprimirSopa
    jmp pedirPalabra

;coloca los punteros en la sopa 3 de la opcion 2   
printsopa3.2:   
sopa3_2 DB 10,13, 'IOGUAYAQNIGER',0Dh,0Ah,'DNQEKBPCIUMRY',0Dh,0Ah
            DB 'JUDUQSEHAQWGE',0Dh,0Ah,'AFRIItaiwanJM',0Dh,0Ah
            DB 'ACteAaUSUIZAE',0Dh,0Ah,'DUZAIAOOlaosN',0Dh,0Ah
            DB 'XUBVNHIOAPLIS',0Dh,0Ah,'ZPRLSCQJRANNH',0Dh,0Ah
            DB 'ROMANIANBTRAW',0Dh,0Ah,'ALEMNNIAIEKSN',0Dh,0Ah
            DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSCHILECSJ',0Dh,0Ah
            DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'
    mov pointersopa, offset sopa3_2
    mov pointerPalabras, offset words3_2
    mov pointerDatosPalabras, offset datos_palabras3_2
    call imprimirSopa
    jmp pedirPalabra

;se imprime la sopa  
imprimirSopa:    
    mov dx, pointersopa 
    mov si, pointerPalabras
    call limpiarPantalla 
    mov ah, 09h          
    int 21h              
    ret                                                  

;se solicita al usuario que ingrese las palabras    
pedirPalabra:
    mov dx, pointersopa 
    mov si, pointerPalabras 
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

;se convierte a minusculas la entrada del usuario para que no sea case-sensitive
convertirAMinuscula:
    mov indicePalabra, 0
    lea bx, [palabraUsuario + 2]      ; Comienza en el tercer byte de palabraUsuario
    mov cl, [palabraUsuario + 1]      ; Carga el número de caracteres ingresados en CL
    or cl, cl                   ; Verifica si CL es 0 (ningún carácter ingresado)
    jz verificarPalabra                ; Si es 0, salta directamente a verificarPalabra
    
    ;loop que convierte cada caracter
    convertir_loop:
        mov al, [bx]            ; Carga el carácter actual en AL
        cmp al, 'A'             ; Comprueba si es una letra mayúscula
        jb siguiente_caracter
        cmp al, 'Z'
        ja siguiente_caracter
        add al, 32              ; Convierte la letra a minúscula
        mov [bx], al            ; Guarda la letra convertida
    
    ;avanzar al siguiente caracter
    siguiente_caracter:
        inc bx                  ; Avanza al siguiente carácter
        dec cl                  ; Decrementa el contador de caracteres
        jnz convertir_loop      ; Continúa si aún hay caracteres por convertir

    jmp verificarPalabra               ; Salta a verificarPalabra después de convertir

;verificar que el usuario haya ingresado una palabra valida o se haya rendido 
verificarPalabra:    
    mov al, [palabraUsuario + 1]      ; Carga el número de caracteres ingresados
    cmp al, 1                   ; Compara si solo se ingresó 1 carácter
    jne siguientePalabra                ; Salta a la etiqueta 'siguientePalabra' si hay más de 1 carácter

    mov al, [palabraUsuario + 2]      ; Carga el primer (y único) carácter ingresado
    cmp al, '0'                 ; Compara con el carácter '0'
    je final                    ; Salta a final si es '0'

;avanzar a comprobar si la palabra esta en la matriz    
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

;verificar si la palabra adivinada ya ha sido adivinada antes                             
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
                             
;avanzar a la siguiente palabra de la matriz                             
encontrarSigPalabra:
    mov al, [si]
    inc si
    cmp al, '$'
    je siguientePalabra
    cmp al, 0
    jne encontrarSigPalabra
    ret

;comparar las palabra respectiva de la matriz con la palabra ingresada por el usuario
compararPalabras:
    push si            ; Guarda el valor original de SI
    push di            ; Guarda el valor original de DI
    push cx            ; Guarda el valor original de CX

    mov di, offset palabraUsuario + 2 ; DI apunta al menu_inicio de palabraUsuario
    mov cx, 20                  ; Longitud máxima de palabraUsuario 
    mov bx, si                   ; BX guarda la posición inicial de la palabra en la lista

;comparar caracter por caracter de las palabra respectiva de la matriz con la ingresada por el usuario
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

;Comprobar si se ha llegado al final de la palabra ingresada por el usuario
CheckFinPalabraUsuario:
    inc bh
    cmp ah, 0Dh                 ; Comprueba si palabraUsuario también terminó
    je iguales                    ; Si es el final, las palabras son iguales

;cuando las palabras son diferentes
diferentes:
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    clc                         ; Limpia el flag de carry
    ret                         ; Retorna sin encontrar coincidencia

;cuando las palabras son iguales
iguales: 
    pop cx                      ; Restaura CX
    pop di                      ; Restaura DI
    pop si                      ; Restaura SI
    stc                         ; Establece el flag de carry para indicar coincidencia
    ret                         ; Retorna con coincidencia encontrada

;si la palabra ingresada por el usuario esta en la matriz y no se ha ingresado antes, se realizan inicializaciones para proceder a resaltar                 
palabrasIguales:
    add contador, 1
    mov ch,1        ;HAYY QUE SETEAR EN 1 AL CONTAR LA PALABRA    
    mov     ax, 3       ;settearr colores
    int     10h              
    mov     ax, 1003h
    mov     bx, 0      ; disable blinking.
    int     10h                
    mov si, pointersopa      ; BX apunta al inicio de sopa +258 no see porque pero funciona        
    mov dx,si            ; Puntero al menu_inicio de la sopa de letras
    mov ah, 09h          ; imprimirSopa cadena
    int 21h
    jmp iniciar_resaltado
    

;si la palabra ingresada por el usuario no esta ingresada en la matriz se vuelve a solicitar palabra                 
palNoEncontrada:
    call limpiarPantalla
    call imprimirSopa
    ; imprimirSopa el mensaje en DX
    mov dx, offset msgNotFound
    mov ah, 09h
    int 21h
    jmp pedirPalabra    
                   
;si la palabra ingresada por el usuario esta en la matriz y ya ha sido adivinada antes se notifica al usuario y se solicita palabra 
palYaAdivinada:
    call limpiarPantalla
    call imprimirSopa
    mov dx, offset msgGuessed
    mov ah, 09h
    int 21h
    jmp pedirPalabra  
     

;se incializa la matriz para resaltar la palabra adivinada
iniciar_resaltado:   
            
    mov ch,1        ;HAYY QUE SETEAR EN 1 AL CONTAR LA PALABRA        
    mov si, pointersopa      ; BX apunta al inicio de sopa +258 no see porque pero funciona  
    push cx
    mov di, pointerDatosPalabras ; para la lista de palabras           
    mov ax,indicePalabra
    mov cl, 4
    mul cl          
    add di, ax        
    mov ch, [di]    
    mov fila, ch ; puntero resaltador --- fila      ; primera posicion    
    
    mov ch, [di + 1]
    mov columna, ch ; puntero resaltador --- columna  ; primera posicion
    
    mov ch, [di + 2]
    mov orientacion,ch
    
    mov ch, [di + 3]
    mov longitud,ch    
      
    pop cx
            
    mov     dl, 0   ; columna actual.
    mov     dh, 1   ; fila actual.       
    jmp     resaltar_loop

;loop para recorrer cada caracter de la palabra adivinada
resaltar_loop:  

    mov al, [si]              ; Carga el carácter actual en AL
    cmp al, '$'               ; Comprueba si es el carácter de terminación
    je  terminar_resaltado             ; Si es así, salta al final

    cmp al, 0Dh
    je ignorar_char
    cmp al, 0Ah
    je ignorar_char                      
                                                 
    
    cmp dl,columna
    je  resaltar_test
                                                           
    cmp dl,13
    je siguiente_fila    
    
    
    inc dl
    inc si                    ; Incrementa el puntero para apuntar al siguiente carácter
    jmp resaltar_loop            ; Repite el bucle 

;se evaluan las filas y columnas del caracter respectivo
resaltar_test:       
    push cx
    mov cl, fila
    cmp dh, fila   ; evaluo i fila
    je resaltar
    
    pop cx                
   
    cmp dl,13
    je siguiente_fila
    
    inc dl
    inc si ; Incrementa el puntero para apuntar al siguiente carácter    
                             
    jmp resaltar_loop 

;una vez se llegue al caracter deseado se empieza a resaltar     
resaltar:  
    push cx            
    ; Set cursor position using the current values in DL and DH
    mov ah, 02h
    int 10h 
    
    mov bl, 03h           ; Atributos de colores
    mov bh, 0             ; Número de página de video, generalmente 0
    mov cx, 1             ; Número de caracteres a imprimir
    mov ah, 09h           ; Función para imprimir el carácter en pantalla
    int 10h    
    pop cx         
    cmp dl,13
    je siguiente_fila    
    inc dl
    inc si
    ; Compare ch with the value at the memory address pointed by ax
     
    cmp ch, longitud   ;COMPARO LONGITUD ; aqui no se porque se guarda 04 00 
    je terminar_resaltado 
        
    pop cx
        
    cmp orientacion, 1
    je horizontal
    
    cmp orientacion, 2
    je vertical
    
    cmp orientacion, 3
    je diagonal
    
                       ; Incrementa el puntero para apuntar al siguiente carácter
    jmp resaltar_loop            

;algoritmo para resaltar las palabras que se encuentran horizontalmente    
horizontal:  
   inc columna
   
   inc ch ; contador de longitud 
   
   jmp resaltar_loop
   
;algoritmo para resaltar las palabras que se encuentran verticalmente  
vertical: 
   inc fila 
   
   inc ch ; contador de longitud 
   
   jmp resaltar_loop

;algoritmo para resaltar las palabras que se encuentran diagonalmente
diagonal:
   inc columna
   
   inc fila
    
   inc ch 
   
   jmp resaltar_loop
       

ignorar_char:
    inc si
    jmp resaltar_loop    
    

siguiente_fila:
    inc     dh
    cmp     dh, 13
    je      terminar_resaltado
    mov     dl, 0      
    jmp resaltar_loop
    
    
terminar_resaltado:
    mov     dl, 0   ; columna actual.
    mov     dh, 0Eh   ; fila actual.
    mov     ah, 02h
    int     10h   
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