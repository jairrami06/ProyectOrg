.model smal   
org 100h                  
.data

                    
              ;brasil       ;peru            ;fRANCIA

datos_sopa DB 1 , 3 , 1 , 6 , 2 , 6 , 2 , 4 , 4 , 1 , 3 ,7  ;; POR ALGUNA RAZON SE DEBE EMPEZZAR DESDE LA FILA 1 ( QUE ES 0)
                        
                                                

fila DB 0
columna DB 0  
orientacion DB 0   
longitud DB 0  




indicePalabra DW 2

  
; Lista de palabras   

sopa DB 10,13,'IFHBRASILCFSM',0Dh,0Ah,'VIAEKBPCIUMNB',0Dh,0Ah
            DB 'LPOIQSEHAQWTE',0Dh,0Ah,'AFRTQWRASDJKL',0Dh,0Ah
            DB 'ACRNTYUZXCVCU',0Dh,0Ah,'XQZAIAMONXZBN',0Dh,0Ah
            DB 'XCBVNHILAPLQS',0Dh,0Ah,'ZPOLSCQJAANJH',0Dh,0Ah
            DB 'QOLSZMINBTREW',0Dh,0Ah,'ALEMANIAIEKSN',0Dh,0Ah
            DB 'XCASEWOJKNMDA',0Dh,0Ah,'EIQKSELICHCSJ',0Dh,0Ah
            DB 'QUWKSMMNXBHJO',0Dh,0Ah,'$'


; Buffer para la palabra del usuario, ajustado para el servicio 0Ah
                                         



.code


start1:  


    mov ch,1        ;HAYY QUE SETEAR EN 1 AL CONTAR LA PALABRA
    
    
    
    mov     ax, 3       ;settearr colores
    int     10h          
    
    mov     ax, 1003h
    mov     bx, 0      ; disable blinking.
    int     10h 
    
   
    
    
    mov si, offset sopa      ; BX apunta al inicio de sopa +258 no see porque pero funciona
    
    
    mov dx,si            ; Puntero al menu_inicio de la sopa de letras
    mov ah, 09h          ; imprimirSopa cadena
    int 21h
    


start:   
            
    mov ch,1        ;HAYY QUE SETEAR EN 1 AL CONTAR LA PALABRA        
    mov si, offset sopa      ; BX apunta al inicio de sopa +258 no see porque pero funciona
     
    
    
    push cx
    
    mov di, offset datos_sopa ; para la lista de palabras   
    
    
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
             
            ;ch  fila
            ;cl  columna
            
    mov     dl, 0   ; columna actual.
    mov     dh, 1   ; fila actual.
     
    
    jmp     print_loop

print_loop:  

    mov al, [si]              ; Carga el carácter actual en AL
    cmp al, '$'               ; Comprueba si es el carácter de terminación
    je  end_print             ; Si es así, salta al final
                ; Si es así, salta al final             ; Si es así, salta al final
                          ; Character to print 
                          
    cmp al, 0Dh
    je ignorar_char
    cmp al, 0Ah
    je ignorar_char                      
                      
                     
      
    
    cmp dl,columna
    je  resaltar_test
    
     
    
                                          
    
    cmp dl,13
    je next_row
    
    
    
    inc dl
    inc si                    ; Incrementa el puntero para apuntar al siguiente carácter
    jmp print_loop            ; Repite el bucle 
    
    
      


resaltar_test:   
    
    
    push cx
    mov cl, fila
    cmp dh, fila   ; evaluo i fila
    je resaltar
    
    pop cx
    
    
   
     
   
    cmp dl,13
    je next_row
    
    inc dl
    inc si
    
    
                         ; Incrementa el puntero para apuntar al siguiente carácter
    jmp print_loop 




     
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
    je next_row
    
    inc dl
    inc si
    
  
    ; Compare ch with the value at the memory address pointed by ax
     
    cmp ch, longitud   ;COMPARO LONGITUD ; aqui no se porque se guarda 04 00 
    je stop_print 
    
    
    pop cx
    
  
    
    cmp orientacion, 1
    je horizontal
    
    cmp orientacion, 2
    je vertical
    
    cmp orientacion, 3
    je diagonal
    
                       ; Incrementa el puntero para apuntar al siguiente carácter
    jmp print_loop 
    
    
    
    
horizontal: 
 
   inc columna

   
   inc ch ; contador de longitud 
   
   jmp print_loop
   
  

vertical: 

   inc fila
 
   
   inc ch ; contador de longitud 
   
   jmp print_loop


diagonal:
 
   inc columna
   
   inc fila
    
   inc ch 
   
   jmp print_loop



        

ignorar_char:
    inc si
    jmp print_loop    


    
    

next_row:
    inc     dh
    cmp     dh, 13
    je      stop_print
    mov     dl, 0      
    jmp print_loop
    
    
stop_print:
    
    mov     ah, 02h
    int     10h 
    mov     dl, 0   ; columna actual.
    mov     dh, 1   ; fila actual. 
    
    
    
    
    
end_print:
    ; Imprimir el mensaje final
    ; Finalizar el programa
    mov ax, 4C00h
    int 21h 