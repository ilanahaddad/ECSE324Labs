#define SIZE_OF_ARRAY(X) (sizeof(X)/sizeof(X[0]))
// gets length of the array in C, stores in register 

int maxVal(int array[], int n) {
	int a, b, temp; 
	for(a=0;a<n-1;a++) 
	{
		for(b=a;b<n;b++) 
		{
			if(array[a]>array[b])
			{
				temp = array[b];
				array[b] = array[a];
				array[a] = temp;
			}
		}
	}
	int last = n;
	return array[last-1];
}

int main() {
	int a[5] = {1,20,3,4,5};
	int size = SIZE_OF_ARRAY(a);
	int max_val = maxVal(a,size);
	return max_val; // returns the value to register R4 because first 3 values are used in the stack 
}


