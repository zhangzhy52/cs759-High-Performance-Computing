#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime.h>
using namespace std;

__global__ void multi(int * dA, int *dB, int * dC, int rowWidth, int colWidth){
	//int id = threadIdx.x +  blockIdx.x * blockDim.x;
	int value = 0;
	for (int i = 0; i < blockDim.x; i++)
		value += dA[blockDim.x * blockIdx.x + i] * dB[i];
	dC[blockIdx.x]  = value;
}


int* read_array(const char* filename, int len) {
	int *x = (int*) malloc(len * sizeof(int));
	FILE *fp = fopen(filename, "r");
	for (int i = 0; i < len; i++) {
		fscanf(fp, "%d", &x[i]);
	}
	fclose(fp);
	return x;
}

int main(int argc, char *argv[]) {
	if (argc != 1) {
		printf("Invalid argument Usage: ./problem1");
		return -1;
	}

	const int rowWidth=32;
    const int colWidth=16;	
	int *hA = read_array("inputA.inp",rowWidth*colWidth );
	int *hB = read_array("inputB.inp", rowWidth);
	int *hC = (int*) malloc(colWidth * sizeof(int));
	int *refC = (int*) malloc (colWidth * sizeof(int));

	// TODO - allocate host memory for refC (you have to figure out how much)
	// The skeleton currently segfaults because refC is accessed without allocation

	// TODO do a reference host implementation (Ch) here. ie populate answer in refC
	for (int i = 0; i < colWidth; i++)
		refC[i] = 0;
	for (int i = 0; i < colWidth; i++)
		for (int j = 0;  j < rowWidth; j++)
		{
			refC[i] += hA[ rowWidth * i + j] * hB[j];
		}



	int *dA, *dB, *dC;
	// TODO allocate device memory for dA,dB and dC
	cudaMalloc( (void**) &dA, sizeof(int) * rowWidth * colWidth);
	cudaMalloc( (void**) &dB, sizeof(int) * rowWidth);
	cudaMalloc((void**) &dC, sizeof(int) * colWidth);


	// TODO copy data from host to GPU 
	cudaMemcpy (dA, hA, sizeof(int) * rowWidth * colWidth, cudaMemcpyHostToDevice);
	cudaMemcpy (dB, hB, sizeof(int) * rowWidth , cudaMemcpyHostToDevice);
	cudaMemcpy (dC, hC, sizeof(int) * colWidth, cudaMemcpyHostToDevice);


	// TODO call your kernel
	multi <<< colWidth ,rowWidth>>> (dA, dB,dC, rowWidth, colWidth);

	// TODO copyback results
	cudaMemcpy(hC, dC, sizeof(int) * colWidth, cudaMemcpyDeviceToHost);


	int Error=0;

	for(int i=0;i<colWidth;i++)
		Error+=sqrt((hC[i]-refC[i])*(hC[i]-refC[i]));
	printf("%d\n%d",Error,hC[colWidth-1]);

	free(refC);
	free(hB);
	free(hA);

	return 0;
}
