			.text
			.global _start

_start: 	MOV R0, #4 // R0 will be our value for the Nth fibonacci number to be calculated, currently set at four
			BL FIB_SEQUENCE // Branch and Link function to subroutine FIB_SEQUENCE, stores address of STOP: in Link Register

STOP:		B STOP //Stops program, saved in first Link Register

FIB_SEQUENCE:
			PUSH {R1, R2, LR} //R1, R2 and the link register are our temporary values and we store them on the stack throughout each iteration
			MOV R1, R0 //R1 takes the value of N, or R0 so R0 can become a temporary register
			CMP R0, #2 // Checks to see if N is less than 2, if it is return 1; like in the C code
			MOV R0, #1 // Stores 1 if N is less than 2
			BLE FIB_DONE //Exits the code
			SUB R0, R1, #2 // Sets up N-2 for the calculation of F(N-2)
			BL FIB_SEQUENCE //branches back to Fibonacci sequence to calculate F(N-2)
			MOV R2, R0 //stores the value of N
			SUB R0, R1, #1 // sets up the calculation for F(N-1) Fibonacci value
			BL FIB_SEQUENCE //Calculation of F(N-1)
			ADD R0, R0, R2 // Adds the sum of F(N-1) and F(N-2)

FIB_DONE:
			POP {R1, R2, LR} // Once the program/iteration has finished we pop all the registers off the stack 
			BX LR //Branch and link function used to go to the address saved in the Link Register		


