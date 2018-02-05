			.text
			.global _start

_start:
//CALLER:
			LDR R4, =RESULT			//R4 points to the result location
			LDR R2, [R4, #4]		//R2 holds the number of elements in the list
			ADD R3, R4, #8			//R3 points to the first number
			LDR R0, [R3]			//R1 holds the first number in the list 

			BL MAX					//branch to max and save address of next instruction in LR
			LDR R0, [SP, #-4]		//load R0 from subroutine into our global R0
			STR R0, RESULT			//store contents of R0 (max) into result in memory

END:		B END					//infinite loop!

//CALLEE:
MAX: 		PUSH {R4, R2, R3, LR}	// push all arguments and LR on the stack to save them

LOOP:		SUBS R2, R2, #1			//decrement the loop counter
			BEQ DONE				//end loop if counter has reached 0
			ADD R3, R3, #4			//R3 points to the next number in the list
			LDR R1, [R3]			//R1 holds the next number in the list
			CMP R0, R1				// check if it is greater than the maximum 
			BGE LOOP				//if no, branch back to the loop
			MOV R0, R1				//if yes, update the current max
			B LOOP					// branch back to the loop

DONE:		//STR R0, [R4]			//store the result to the memory location
			PUSH {R0}				//push R0 onto next spot in stack
			POP {LR, R3, R2, R4}
			BX LR

RESULT:		.word 0					//memory assigned for result location
N:			.word 7					//nuber of entries in the list
NUMBERS:	.word 4, 5, 3, 6		//the list data
			.word 1, 8, 2
