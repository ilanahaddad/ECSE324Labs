			.text
			.global _start

_start: 

			LDR R12, =SORTED		//R12 holds the location of boolean sorted 
			LDR R11, [R12]			//R11 holds the value of the boolean sorted (0==false, 1==true)
			LDR R1, [R12, #4]		//R1 holds the number of elements in the list
			ADD R2, R12, #8			//R2 points to the first number in the list 
			LDR R3, [R2] 			//R3 holds the value of the first number in the list
			MOV R10, #1

OUTERLOOP:	CMP R11, #1				// compare value of SORTED boolean to 1 
			BEQ DONESORT			// if SORTED==1==TRUE, branch to DONESORT
			MOV R11, #1				// set sorted boolean to true
			//RESET INITIAL VALUES
			LDR R1, [R12, #4]		//R1 holds the number of elements in the list
			ADD R2, R12, #8			//R2 points to the first number in the list 
			LDR R3, [R2] 			//R3 holds the value of the first number in the list

INNERLOOP:	SUBS R1, R1, #1			//decrement loop counter (# of elements in list -1)
			BEQ OUTERLOOP			//if value reaches 0, go back to outerloop to check if we are done sorting
			ADD R2, R2, #4			//R2 points to next number in list
			LDR R4, [R2]			//R4 holds value of next number in the list
			LDR R3, [R2, #-4]		//R3 holds value of previous number in the list
			CMP R3, R4				//check whether previous number is smaller than the next
			BLT INNERLOOP			//if yes, no swap needed, branch to INNERLOOP
			MOV R11, #0				//if no, swap is needed, set sorted boolean to false
			MOV R5, R4				//move the next number (smaller) to temporary location R5
			MOV R6, R3				//move the previous number (larger) to temporary location R6
			MOV R3, R5				//move the smaller number to R3
			MOV R4, R6				//move the larger number to R4
			STR R3, [R2, #-4]		//store the smaller number at prev location
			STR R4, [R2]		//store the larger number at next spot in array 
			B INNERLOOP 


DONESORT: 	STR R10, [R12]			//stores the contents of R4 at the location R12 points to 
									//change value of SORTED in memory to 1 (sorted is true)
END:		B END					//infinite loop!

SORTED: 	.word 0					//memory location assigned for boolean sorted (0==false, 1==true)
N:			.word 4					//nuber of entries in the list
ARRAY:		.word 4, 3, 2, 1		//list of numbers to sort

