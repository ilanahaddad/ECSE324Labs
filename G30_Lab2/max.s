			.text
			.global _start
_start:
//CALLER:
            LDR R0, =NUMBERS        //R0 points to first element in array
            LDR R1, =N              //R1 points to number of elements in array
            LDR R1, [R1]            //R1 holds the number of elements in array

            BL MAX
            //after this, result is stored in RO
            STR R0, RESULT          //store contents of R0 at address RESULT

END:		B END					//infinite loop!
//CALLEE:   Assume R0 = Array, R1 = N
//push registers used in sub routine on stack so they remain unchanged outside of the subroutine
MAX:        PUSH {R1, R5, R6}
            LDR R5, [R0]            //load into R5 the first element in the array. set as temp max
LOOP:       SUBS R1, R1, #1         //use N as loop counter and subtract until we reach 0
            BEQ DONE
            ADD R0, R0, #4          //R0 points to next element in array
            LDR R6, [R0]            //R6 holds the next element in array
            CMP R5, R6              //compare 'max' to next element in array
            BGE LOOP                //if max>R6, go back to top of loop
            MOV R5, R6              //if R6>max, update R5 to have the max value (R6)
            B LOOP                  //go back to top of loop for next iteration

DONE:       MOV R0, R5              //move result of max value into R0
            POP {R1, R5, R6}         //now these registers have their original values again
            BX LR                   //go back to instruction after subroutine was called

RESULT:		.word 0					//memory assigned for result location
N:			.word 7					//nuber of entries in the list
NUMBERS:	.word 4, 5, 20, 6		//the list data
			.word 1, 8, 2
