.model smal   
org 100h                  
.data

                   
palabra DB 'Ecuador' 


datos_sopa DB 1 , 0 , 1 , 7 , 2 , 6 , 1 , 4 , 5 , 0 , 1 ,3 , 8 ,0 , 1 , 5 , 12 , 4 , 1 , 8 ;; POR ALGUNA RAZON SE DEBE EMPEZZAR DESDE LA FILA 1 ( QUE ES 0)
                        
                                                

fila DB 0
columna DB 0  
orientacion DB 0   
longitud DB 0  




indicePalabra DW 0

  
; Lista de palabras   

sopa DB 10,13,'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
           DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
           DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
           DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
           DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
           DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
           DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'

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

    mov al, [si]              ; Carga el car�cter actual en AL
    cmp al, '$'               ; Comprueba si es el car�cter de terminaci�n
    je  end_print             ; Si es as�, salta al final
                ; Si es as�, salta al final             ; Si es as�, salta al final
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
    inc si                    ; Incrementa el puntero para apuntar al siguiente car�cter
    jmp print_loop            ; Repite el bucle 
    
    
      


resaltar_test:   
    
    
    cmp dh, fila   ; evaluo i fila
    je resaltar
     
   
    cmp dl,13
    je next_row
    
    inc dl
    inc si
    
    
                         ; Incrementa el puntero para apuntar al siguiente car�cter
    jmp print_loop 




     
resaltar: 
    
    
    
    push cx    
    
    
    ; Set cursor position using the current values in DL and DH
    mov ah, 02h
    int 10h 
    
    mov bl, 03h           ; Atributos de colores
    mov bh, 0             ; N�mero de p�gina de video, generalmente 0
    mov cx, 1             ; N�mero de caracteres a imprimir
    mov ah, 09h           ; Funci�n para imprimir el car�cter en pantalla
    int 10h 
    
    
    pop cx 
    
    
    
    cmp dl,13
    je next_row
    
    inc dl
    inc si
    
  
    ; Compare ch with the value at the memory address pointed by ax

         
    cmp ch, longitud   ;COMPARO LONGITUD ; aqui no se porque se guarda 04 00 
    je stop_print 
    
    
  
    
    cmp orientacion, 1
    je horizontal
    
    cmp bh, 2
    je vertical
    
    cmp bh, 3
    je diagonal
    
                       ; Incrementa el puntero para apuntar al siguiente car�cter
    jmp print_loop 
    
    
    
    
horizontal: 
 
   inc columna

   
   inc ch  
   
   jmp print_loop
   
  

vertical: 

   inc fila
 
   
   inc ch  
   
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
    
    mov indicePalabra, 1
    jmp start
    
    
    
    
end_print:
    ; Imprimir el mensaje final
    ; Finalizar el programa
    mov ax, 4C00h
    int 21h 