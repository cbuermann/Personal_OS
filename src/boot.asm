; boot.asm
BITS 16
ORG 0x7C00             ; Bootloader loads at 0x7C00

start:
    ; Set up segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Print message
    mov si, message

print_char:
    lodsb                ; Load next byte from [si] into AL
    cmp al, 0
    je done              ; End of string
    mov ah, 0x0E         ; BIOS teletype function
    mov bh, 0x00         ; Page number
    mov bl, 0x07         ; Text attribute (white)
    int 0x10             ; Call BIOS video
    jmp print_char

done:
    cli                  ; Clear interrupts
    hlt                  ; Halt CPU

message db 'Welcome to Personal OS', 0

; Fill the rest of the sector with zeros and add boot signature
times 510-($-$$) db 0
dw 0xAA55
