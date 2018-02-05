			.text
			.global _start

_start: 
//CALCULATING THE MAX:
			LDR R4, =RESULT			//R4 points to the result location
			LDR R2, [R4, #8]		//R2 holds the number of elements in the list
			ADD R3, R4, #12			//R3 points to the first number
			LDR R0, [R3]			//R0 holds the first number in the list 

LOOP:		SUBS R2, R2, #1			//decrement the loop counter
			BEQ DONE				//end loop if counter has reached 0
			ADD R3, R3, #4			//R3 points to the next number in the list
			LDR R1, [R3]			//R1 holds the next number in the list
			CMP R0, R1				// check if it is greater than the maximum 
			BGE LOOP				//if no, branch back to the loop
			MOV R0, R1				//if yes, update the current max
			B LOOP					// branch back to the loop

DONE:		STR R0, [R4]			//store the result to the memory location

//CALCULATING THE MIN
			LDR R5, =RESULTMIN			//R5 points to the location of unused register r12
			LDR R2, [R4, #8]		//R2 holds the number of elements in the list
			ADD R3, R4, #12			//R3 points to the first number
			LDR R0, [R3]			//R0 holds the first number in the list 

LOOP2:		SUBS R2, R2, #1			//decrement the loop counter
			BEQ DONE2				//end loop if counter has reached 0
			ADD R3, R3, #4			//R3 points to the next number in the list
			LDR R1, [R3]			//R1 holds the next number in the list
			CMP R0, R1				// compare which is less 
			BLE LOOP2				//if no, branch back to the loop
			MOV R0, R1				//if yes, update the current min
			B LOOP2					// branch back to the loop

DONE2:		STR R0, [R5]			//store the result to the memory location
//R4 STORES THE MAX
//R5 STORES THE MIN
			LDR R4, [R4]			//store in R4 the value that the address in R4 points to in memory (max)
			LDR R5, [R5]			
			SUBS R12, R4, R5
//shift right by 2 bits = division by 2^2
			ASR R11, R12, #2		//divide r12 by 4 and store in r11
END:		B END					//infinite loop!

RESULT:		.word 0					//memory assigned for result location
RESULTMIN:	.word 0 				//memory assigned for result location
N:			.word 7					//nuber of entries in the list
NUMBERS:	.word 4, 5, 3, 6		//the list data
			.word 1, 8, 2
