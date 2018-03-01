		.text
		.equ	PB_DATA, 0xFF200050
		.equ	PB_EDGECAP, 0xFF200058
		.equ	PB_INT,	0xFF20005C	
		.global	read_PB_data_ASM
		.global PB_data_is_pressed_ASM
		.global	read_PB_edgecap_ASM
		.global PB_edgecap_is_pressed_ASM
		.global PB_clear_edgecap_ASM
		.global enable_PB_INT_ASM
		.global disable_PB_INT_ASM

read_PB_data_ASM:
			LDR R0, =PB_DATA	
			LDR R0, [R0]		
			BX LR

PB_data_is_pressed_ASM:
			LDR R1, =PB_DATA	//Load address of pb data
			LDR R1, [R1]		//Load value at that address
			AND R2, R1, R0		//Check if a button has been pressed
			CMP R2, R0			
			MOVEQ R0, #1		//If a button has been pressed set R0 to 1 (which will be true)
			MOVNE R0, #0		//If a button has not been pressed set R0 to 0 (which will be false)
			BX LR				// eturn 

read_PB_edgecap_ASM:
			LDR R0, =PB_EDGECAP	//Load address of pb edgecap
			LDR R0, [R0]	//Load value at edge cap
			AND R0, R0, #0xF		//Get only edge cap bits
			BX LR

PB_edgecap_is_pressed_ASM:  	// Same as PB_data_is_pressed_ASM besides 
			LDR R1, =PB_EDGECAP	
			LDR R1, [R3]		// here where we load the edgcap register
			AND R2, R1, R0		
			CMP R2, R0			
			MOVEQ R0, #1		
			MOVNE R0, #0		
			BX LR

PB_clear_edgecap_ASM:
			LDR R2, =PB_EDGECAP	//Load address of pb edgecap
			MOV R1, #0x7
			STR R1, [R2]	//Stores all 1s in the edgecap (resetting it)
			BX LR

enable_PB_INT_ASM:
			LDR R2, =PB_INT	//Load address of pb interrupt mask
			AND R1, R0, #0xF	//Only load bits we want to enable
			STR R1, [R2]	//Store it back into the register
			BX LR

disable_PB_INT_ASM:
			LDR R2, =PB_INT	//Load address of pb interrupt mask
			LDR R1, [R2]	//Load value at interrupt mask
			BIC R1, R1, R0		//Bit clear the corresponding bit(s)
			STR R1, [R2]	//Store back into the register
			BX LR

			.end
