name Proyecto
include 'emu8086.inc'
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
  
salto db 10,13,'$'
msg1.1 db ''     
.code
.start


; Inicio del programa
inicio: 
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
    print 'Ingrese un numero: '
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
sopa DB 'BRASILXXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'FRANCIAXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov dx, offset sopa ; Puntero al inicio de la sopa de letras
    jmp imprimir
    
printsopa2:   
sopa2 DB 'ECUADORXXXXXX',0Dh,0Ah,'XXXXXXPERUXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'USAXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'CHILEXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXXXXXXXXXX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'XXXXALEMANIAX',0Dh,0Ah
     DB 'XXXXXXXXXXXXX',0Dh,0Ah,'$'
    mov dx, offset sopa2 ; Puntero al inicio de la sopa de letras
    jmp imprimir
  
imprimir: 
    mov ah, 09h          ; imprimir cadena
    int 21h              ; Interrupcion del DOS para imprimir
    jmp final
    
final:
; Esperar una tecla para terminar
    mov ah, 00h
    int 16h
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