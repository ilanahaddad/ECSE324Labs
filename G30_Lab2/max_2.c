

/* This program demonstrates the use of parallel ports in the DE1-SoC Computer
 * It performs the following: 
 * 	1. displays the SW switch values on the red lights LEDR
 * 	2. displays a rotating pattern on the HEX displays
 * 	3. if a KEY[3..0] is pressed, uses the SW switches as the pattern
*/
extern int MAX_2(int x, int y);
int main(){
	int a,b,c;
	a = 1;
	b = 2;
	c = MAX_2(a,b);
	return c;
}
