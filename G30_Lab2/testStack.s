			.text
			.global _start

_start: 	MOV R0, #5
			MOV R1, #6
			//MULTIPLE PUSH:
			STMDB SP!, {R0, R1}			//loads contents of R0 and R1 into the stack, while decrementing the sp 
			//STMDB: Store Multiple Decrement Before

			//MULTIPLE POP: 
			LDMIA SP!, {R2, R3}			//loads two last contents of stack into registers R2 and R3 while incrementing the sp
			//LDMIA: Load Multiple Increment After

END:		B END
