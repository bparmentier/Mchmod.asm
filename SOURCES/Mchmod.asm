;NOM    : Mchmod.asm
;CLASSE : FS - FS078
;OBJET  : réservé au makefile
;AUTEUR : Bruno Parmentier, 02/2014
;BUGS   : pas de vérification sur la valeur entrée pour le mode
;USAGE  : ./Mchmod 644 fichier

global main

section .data

missopmsg       db      "Mchmod : opérande manquant", 10
missopmsglen    equ     $ - missopmsg
fnotfoundmsg    db      "Mchmod : aucun fichier ou dossier de ce type", 10
fnotfoundmsglen equ     $ - fnotfoundmsg

section .bss

mode    resd    1

section .text
main:
    mov ebp, esp    ; ebp pointe sur la chaine
    mov ecx, [ebp]  ; ecx = nombre d'arguments a afficher - 1
    mov esi, 8  ; le premier argument utile est 8 bytes plus loin
    cmp ecx, 1
    je missop
    push dword [ebp + esi]  ; place l'adresse du mode sur la pile
    call modeconv
    add esi, 4  ; passe à l'argument suivant (fichier)

.argum:
    cmp ecx, 2  ; encore des fichiers à traiter ?
    je exit
    push dword [ebp + esi]  ; place l'adresse de ce nom de fichier sur la pile
    call chmod
    add esi, 4  ; passe à l'argument suivant
    dec ecx
    jmp .argum  ; pour tous les arguments

; fin du programme
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80

; opérande manquant
missop:
    mov eax, 4
    mov ebx, 1
    mov ecx, missopmsg
    mov edx, missopmsglen
    int 0x80

    jmp exit

; fichier ou dossier non trouvé
fnotfound:
    mov eax, 4
    mov ebx, 1
    mov ecx, fnotfoundmsg
    mov edx, fnotfoundmsglen
    int 0x80

    jmp exit

; appel système chmod
chmod:
    push ebp
    mov ebp, esp
    pusha

    mov eax, 15 ; numéro de l'appel système
    mov ebx, [ebp + 8]  ; chemin du fichier
    mov ecx, [mode] ; mode (format octal)
    int 0x80

    cmp eax, 0
    jne fnotfound
    popa
    pop ebp
    ret 4

; conversion du mode entré en premier argument en octal
modeconv:
    push ebp
    mov ebp, esp
    pusha
    mov ecx, [ebp + 8]
    xor eax, eax    ; mise à zéro de eax
    xor ebx, ebx    ; mise à zéro de ebx
 
.suiv:
    cmp byte [ecx], 0
    je .fin

    mov al, byte [ecx]
    sub al, '0' ; conversion du caractère ascii en nombre
    add ebx, eax
    shl ebx, 3  ; ebx = ebx * 8

    inc ecx
    jmp .suiv

.fin:
    shr ebx, 3  ; suppression des 3 derniers bits de l'opération précédente
    mov dword [mode], ebx
    popa
    pop ebp
    ret 4
