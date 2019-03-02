;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

            mov.w   #0x2400, r15			; R15 i baslattigim adres
            mov.w   #0x4400, r10			; R10 u geriye döngü için kullanacaðým

            mov.w   #0, r11					; R11 e 0 degeri
            mov.w   r11, 0(r15)

            mov.w   #1, r12					; R12 ye 1 degeri
            incd    r15						; R15 in adresi 2 li artiyor
            mov.w   r14, 0(r15)

            mov.w 	r15, &0x2400			; bu kisim iki register kullnabilmek icin
			mov.w 	r14, &0x2408
			mov.w 	&0x240a, r14
			mov.w 	&0x240c, r15

loop        tst     r10						;R10 testi
            jz      forever					;0 degilse devam

            incd    r15
            dec     r10						;R10 daki deger azaliyor

            mov.w   r12, r9					;deger saklaniyor
            add.w   r11, r12				;toplama
            mov.w   r9, r11					;saklanan deger aliniyor
            jmp     loop

forever     jmp     forever
			nop
                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
