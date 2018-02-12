			.text
			.global _start

_start: 	MOV R0, #4 // R0 will be our value for the Nth fibonacci number to be calculated, currently set at four
			BL FIBONACCI // branch link function to subroutine Fibonacci

STOP:		B STOP //Done case

FIBONACCI:	PUSH {R1, R2, LR} //we use R1, R2, R3 as temporary registers during this subroutine so we store tem on the stack as they change value
			MOV R1, R0 //R1 gets the value of R0 it is a temporary variable essentialyl
			CMP R0, #2 // our exit case if N<=2
			MOV R0, #1 // if true store 1
			BLE FIB_DONE //and exit
			SUB R0, R1, #2 // subtract R0 by 2
			BL FIBONACCI //branch back i.e. fib(n-2)
			MOV R2, R0 //this is for the case Fib(n-1)
			SUB R0, R1, #1 // basically n = n-1 
			BL FIBONACCI //fib(n-1)
			ADD R0, R0, R2 // do the sum of fib(n-1) and fib(n-2)

FIB_DONE:
			POP {R1, R2, LR} // we pop all our variables off the stack because we are done
			BX LR //simply go to next instruction			


