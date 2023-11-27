data segment
 string db "proce'so'r"
 stringlen equ $-string   ; subtract current string's address from current address
ends

start:

    mov ax, data
    mov ds, ax     ; Assuming rkhb is correct about segments

    lea   di, string
    mov   cx, stringlen   ; having the assembler generate this constant from the length of the string prevents bugs if you change the string

    ;; if stringlen can be zero:
     ;  test cx,cx
     ;  jz end

    ;; .labels are "local" and don't end up as symbols in the object file, and don't have to be unique across functions
    ;; emu8086 may not support them, and this Q is tagged as 8086, not just 16bit DOS on a modern CPU.
    print_loop:
        mov   dl, [di]
        mov   ah, 02h  ; If int21h doesn't clobber ah, this could be hoisted out of the loop.  IDK.
        int   21h 

        inc   di
        dec   cx
        jg   print_loop  ;  or jne
    end:

          ;  Or save a register (and the mov to initialize it) with
          ;   cmp  di, offset string+stringlen 
          ;   jb   print_loop

         ;; loop print_loop  ; or save instruction bytes, but slower on modern CPUs

mov ax, 4c00h
int 21h