#define SIZE_OF_ARRAY(X) (sizeof(X)/sizeof(X[0]))
// gets length of the array in C, stores in register. size of array is number of bytes divided by 4 bytes = # of elements in array

int main() {
	int a[5] = {1,20,3,4,5};
	int size = SIZE_OF_ARRAY(a);
	int i;
	int max =0;
	for(i=0; i<size;i++){
		if(a[i]>max){
			max = a[i];
		}
	}
	//int max_val = maxVal(a,size);
	return max; // returns the value to register R4 because first 3 values are used in the stack 
}


