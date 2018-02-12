

/* This program demonstrates the use of parallel ports in the DE1-SoC Computer
 * It performs the following: 
 * 	1. displays the SW switch values on the red lights LEDR
 * 	2. displays a rotating pattern on the HEX displays
 * 	3. if a KEY[3..0] is pressed, uses the SW switches as the pattern
*/
extern int MAX_2(int x, int y);
int main(){
    int array[4] = {2,8,5,10};
    int max = 0;
    int arrayLength = sizeof(array)/4;
    int tempMax;
    for(int i=0; i < arrayLength-1; i++){
        tempMax = MAX_2(array[i], array[i+1]);
        if (tempMax>max){
            max = tempMax;
        }
    }
	return max;
}
