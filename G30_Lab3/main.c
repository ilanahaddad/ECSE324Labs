#include <stdio.h>
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

int main(){
	 while (1) {
		 	// poll slider switches 
			write_LEDs_ASM(read_slider_switches_ASM()); //if switch 9 is activated clear all displays 
			if (0x200 & read_slider_switches_ASM()) { 
				HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
			} else {
				HEX_flood_ASM(HEX4 | HEX5); //since there are no pushbuttons to correspond to HEX4 and HEX5, switch on all the segemnts of these two displays
				HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3); // clear is used to avoid display glitches.
				//Each button is associated to a hex display and the first 4 switches are 4 bit binary number to be displays in hex.
				HEX_write_ASM((0xF & read_PB_data_ASM()), (0xF & read_slider_switches_ASM()));
		}
	}

	return 0;
}
/*
int main(){
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
	}
	return 0;
}
*/
