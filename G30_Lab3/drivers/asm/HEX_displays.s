		.text
		.equ	HEX_BASE0, 0xFF200020	
		.equ	HEX_BASE4, 0xFF200030
		.global	HEX_clear_ASM
		.global HEX_flood_ASM
		.global	HEX_write_ASM

HEX_clear_ASM:
				PUSH {R4-R12, LR}
	 			LDR R1, =HEX_BASE0			// Load the register containing the first six hex displays
				LDR R2, =HEX_BASE4			// Load the register containing the last 2 hex displays 
				MOV R3, #0x00				// HEX value that clears the hex displays 
				MOV R4, #1					// Used to compare with each bit of the received parameter
				MOV R6, #0					// Set initial counter value to 0 
LOOP5:			
				CMP R6, #4					// When reached the 4th display 
				BEQ LOOP6					// Go to the next loop(6)
				AND R5, R0, R4				
				CMP R5, #0					//if the bit is not one skip the clear (not a display passed as parameter)
				BEQ SKIP5
				STRB R3, [R1]				//Clears the display 
SKIP5:		
				ADD R1, R1, #1				// increment address to next hex display 
				LSL R4, R4, #1				// increment comparor to next binary bit
				ADD R6, R6, #1				// increment counter 
				B LOOP5						
LOOP6:			
				CMP R6, #6					// End the program when all the displays have been checked. 
				BEQ DONE3
				AND R5 ,R0, R4				// Same process as before
				CMP R5, #0
				BEQ SKIP6
				STRB R3, [R2]
SKIP6:		
				LSL R4, R4, #1
				ADD R2, R2, #1
				ADD R6, R6, #1
				B LOOP6
DONE3:			
				POP {R4-R12, LR}
				BX LR						// return 

HEX_flood_ASM:	// This function is the same as the previous one the only change is 
				PUSH {R4-R12, LR}
	 			LDR R1, =HEX_BASE0
				LDR R2, =HEX_BASE4
				MOV R3, #0x7F		//here this value floods the display (lights all the segments)
				MOV R4, #1
				MOV R6, #0
LOOP:			
				CMP R6, #4
				BEQ LOOP2
				AND R5, R0, R4
				CMP R5, #0
				BEQ SKIP
				STRB R3, [R1]
SKIP:		
				ADD R1, R1, #1
				LSL R4, R4, #1
				ADD R6, R6, #1
				B LOOP
LOOP2:			
				CMP R6, #6
				BEQ DONE
				AND R5 ,R0, R4
				CMP R5, #0
				BEQ SKIP2
				STRB R3, [R2]
SKIP2:		
				LSL R4, R4, #1
				ADD R2, R2, #1
				ADD R6, R6, #1
				B LOOP2
DONE:			
				POP {R4-R12, LR}
				BX LR

HEX_write_ASM:  // This function is the same as the previous ones except for: 
				PUSH {R4-R12, LR}
	 			LDR R2, =HEX_BASE0
				LDR R3, =HEX_BASE4
				LDR R4, =HEX_VALUE 	// here
				LDRB R5, [R4, R1]	// This goes to array to get the value associated to the HEX value we want to display 
				MOV R6, #0x7F
				MOV R7, #1
				MOV R8, #0
LOOP3:			
				CMP R8, #4
				BEQ LOOP4
				AND R9, R0, R7
				CMP R9, #0
				BEQ SKIP3
				STRB R5, [R2]
SKIP3:		
				ADD R2, R2, #1
				LSL R7, R7, #1
				ADD R8, R8, #1
				B LOOP3
LOOP4:			
				CMP R8, #6
				BEQ DONE2
				AND R9 ,R0, R7
				CMP R9, #0
				BEQ SKIP4
				STRB R5, [R3]
SKIP4:		
				LSL R7, R7, #1
				ADD R3, R3, #1
				ADD R8, R8, #1
				B LOOP4
DONE2:			
				POP {R4-R12, LR}
				BX LR
				
HEX_VALUE:		.byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7F, 0x39, 0x3F, 0x79, 0x71 				
				.end
		
