.text
.equ LED_BASE, 0xFF200000
.global read_LEDs_ASM
.global write_LEDs_ASM

read_LEDs_ASM:
	LDR R1, =LED_BASE		//load LED memory lecoation 
	LDR R0, [R1]			//load the value at LEDs memory location into R0
	BX LR					//branch to LR

write_LEDs_ASM:
	LDR R1, =LED_BASE		//load LED memory location
	STR R1, [R0]			//store value into R0
	BX LR