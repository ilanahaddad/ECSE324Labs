			.text
			.global _start

_start: 
//CENTERING A SIGNAL:
//CALCULATE AVERAGE VALUE OF THE SIGNAL
//Step 1: calculate sum of numbers:


			LDR R12, =RESULT		//R12 points to the result location
			LDR R2, [R12, #4]		//R2 holds the number of elements in the list
			ADD R4, R12, #8			//R4 now points to the first number in the list 
			LDR R5, [R4] 			//R5 now holds the value of the first number in the list
			MOV R3, #0				//R3 will hold the value of the sum of numbers in the list
			MOV R6, #0				//R6 will hold the new value of element (element - average)

LOOPADD:	ADD R3, R3, R5			//add next element of the list to the sum, that is stored in R3
			SUBS R2, R2, #1			//decrement R2 in order to stop loop once we have seen every element in list
			BEQ AVERAGE				// if R2 == 0, branch to AVERAGE
			ADD R4, R4, #4			//R4 points to the next number in the list
			LDR R5, [R4]			//R5 now holds the next element in the list
			B LOOPADD				// branch to LOOPADD label to repeat steps
			
			
AVERAGE: 	MOV R1, #0				// store 0 in R1, this will hold the value of our average
									//shift right by N bits = division by 2^N
			ASR R1, R3, #2			//divide R3 (sum) by 2^N (4) and store in R6
			
//RETRIEVE ORIGINAL VALUES AND LOAD THEM TO RESPECTIVE REGISTERS:
			LDR R2, [R12, #4]		//R2 holds the number of elements in the list
			ADD R4, R12, #8			//R4 points back to the first number in the list 
			LDR R5, [R4] 			//R5 now holds the value of the first number in the list

//SUBTRACT THE AVERAGE FROM EVERY SAMPLE OF THE SIGNAL
LOOPCENTER: SUB R6, R5, R1			//R6 = element in list - average
			STR	R6, [R4]			//R4 holds address of the element in the list, so we want to store our new value at that address in memory
			SUBS R2, R2, #1			//decrement R2 in order to stop loop once we have seen every element in list
			BEQ END					// if R2 == 0, branch to END
			ADD R4, R4, #4			//R4 points to the next number in the list
			LDR R5, [R4]			//R5 now holds the next element in the list
			B LOOPCENTER			// branch to LOOPCENTER label to repeat steps

END:		B END					//infinite loop!

RESULT: 	.word 0
N:			.word 4					//nuber of entries in the list
SIGNAL:		.word 1, 2, 3, 4 		//list of numbers for our signal 

