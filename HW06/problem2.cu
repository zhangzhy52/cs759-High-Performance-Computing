#include<iostream>

#include<cuda.h>

using namespace std;

__global__ void kernel(int *data)
{
	data[threadIdx.x + blockIdx.x * 8 ] = threadIdx.x + blockIdx.x;
}


int main(){
	const int numElem = 16;
	int hostArray[numElem], *dArray;
	
	// 
	cudaMalloc ( (void**) &dArray, sizeof(int) * numElem );
	cudaMemset (dArray, 0, numElem * sizeof (int));
	

	kernel <<< 2, 8 >>>( dArray);
	
	cudaMemcpy(&hostArray, dArray, sizeof (int) * numElem , cudaMemcpyDeviceToHost);

	for (int i = 0 ; i < numElem; i++)
		cout << hostArray[i] << endl;
	cudaFree(dArray);
	return 0;
}
