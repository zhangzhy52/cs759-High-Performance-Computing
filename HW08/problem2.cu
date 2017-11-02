#ifdef _WIN32
#  define NOMINMAX 
#endif

// includes, system
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctime>
// includes, project

// includes, kernels
#include <cuda.h>
#include <cuda_runtime.h>

#define MAX_TILE_SIZE 1024
////////////////////////////////////////////////////////////////////////////////
// declaration, forward

double* read_array(const char* filename, int len) {
	double *x = (double*) malloc(len * sizeof(double));
	FILE *fp = fopen(filename, "r");
	for (int i = 0; i < len; i++) {
		fscanf(fp, "%lf", &x[i]);
	}
	fclose(fp);
	return x;
}

__global__ void computeOnDevice(double* dA,double* dB, double* dC, int nRows, int tileSize, float* incTime)
{

    __shared__ float ds_M[MAX_TILE_SIZE];
    __shared__ float ds_N[MAX_TILE_SIZE];
    int bx = blockIdx.x, by = blockIdx.y,
       tx = threadIdx.x, ty = threadIdx.y,
       Row = by * tileSize + ty,
       Col = bx * tileSize + tx;
    double Pvalue = 0;

    for (int m = 0; m < (nRows-1)/tileSize+1; ++m) {
       if (Row < nRows && m*tileSize+tx < nRows)
          ds_M[ty * tileSize + tx] = dA[Row*nRows + m*tileSize+tx];
       else
          ds_M[ty * tileSize + tx] = 0;
       if (Col < nRows && m*tileSize+ty < nRows)
          ds_N[ty * tileSize + tx] = dB[(m*tileSize+ty)*nRows+Col];
       else
          ds_N[ty * tileSize + tx] = 0;

       __syncthreads();
       for (int k = 0; k < tileSize; ++k)
          Pvalue += ds_M[ty * tileSize + k] * ds_N[k * tileSize + tx];
       __syncthreads();
    }

    if (Row < nRows && Col < nRows)
       dC[Row*nRows+Col] = Pvalue;

	return;//Placeholder
}

////////////////////////////////////////////////////////////////////////////////
// Program main
////////////////////////////////////////////////////////////////////////////////

int main( int argc, char** argv) 
{
	if(argc!=2)
	{
		printf("Usage: ./problem2 N\n");
		return 0;
	}
	int nRows = 1024;
	int num_elements = nRows*nRows;
	int tileSize = atoi(argv[1]);  //change this for scaling analysis
	float incTime=0; // Time for GPU
	double* hA = read_array("inputA.inp",num_elements);
	double* hB = read_array("inputB.inp",num_elements);
	double* hC = (double*) malloc(num_elements * sizeof(double));

	dim3 dimGrid((nRows - 1) / tileSize + 1, (nRows - 1) / tileSize + 1, 1);
	dim3 dimBlock(tileSize, tileSize, 1);

	double * dA, *dB, *dC;

	cudaError error = cudaMalloc((void**)&dA, sizeof(double)*num_elements);
	error = cudaMalloc((void**)&dB, sizeof(double)*num_elements);
	error = cudaMalloc((void**)&dC, sizeof(double)*num_elements);

	cudaMemcpy(dA, hA, sizeof(double)*num_elements, cudaMemcpyHostToDevice);
	cudaMemcpy(dB, hB, sizeof(double)*num_elements, cudaMemcpyHostToDevice);

    cudaEvent_t startEvent_inc, stopEvent_inc;
	cudaEventCreate(&startEvent_inc);
	cudaEventCreate(&stopEvent_inc);
    cudaEventRecord(startEvent_inc,0); // starting timing for inclusive

	// **===-------- Modify the body of this function -----------===**
	computeOnDevice<<<dimGrid, dimBlock>>>(dA, dB, dC, nRows, tileSize, &incTime);
	// **===-----------------------------------------------------------===**
	cudaThreadSynchronize();
	cudaMemcpy(hC, dC, sizeof(double)*num_elements, cudaMemcpyDeviceToHost);
	
	cudaEventRecord(stopEvent_inc,0);  //ending timing for inclusive
	cudaEventSynchronize(stopEvent_inc);   
	cudaEventElapsedTime(&incTime, startEvent_inc, stopEvent_inc);
	printf("%lf\n%f\n%d\n",hC[num_elements - 1],incTime,tileSize);
	// cleanup memory
	free(hA);
	free(hB);
	free(hC);

	return 0;
}


