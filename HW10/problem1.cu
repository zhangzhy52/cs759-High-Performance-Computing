//#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include <cuda.h>
//#include <math.h>

#define BLOCK_SIZE 512

int checkResults(float*res, float* cudaRes,int length)
{
	int nDiffs=0;
	const float smallVal = 0.01f; // Keeping this extra high as we have repetitive addition and sequence matters
	for(int i=0; i<length; i++)
		if(fabs(cudaRes[i]-res[i])>smallVal)
            nDiffs++;
        //if(1)
            //printf("%d :: %f  %f\n", i, cudaRes[i], res[i]);
	return nDiffs;
}

void initializeArray(FILE* fp,float* arr, int nElements)
{
	for( int i=0; i<nElements; i++){
		int r=fscanf(fp,"%f",&arr[i]);
		if(r == EOF){
			rewind(fp);
		}
		arr[i]-=5; // This is to make the data zero mean. Otherwise we reach large numbers and lose precision
	}
}

void inclusiveScan_SEQ(float *in, float *out,int length) {
	float sum=0.f;
	for (int i =0; i < length; i++) {
		sum+=in[i];
		out[i]=sum;
	}
}


__global__ void fixup(float *input, float *aux, int len) {
    unsigned int t = threadIdx.x, start = 2 * blockIdx.x * BLOCK_SIZE;
    if (blockIdx.x) {
        if (start + t < len)
            input[start + t] += aux[blockIdx.x - 1];
        if (start + BLOCK_SIZE + t < len)
            input[start + BLOCK_SIZE + t] += aux[blockIdx.x - 1];
    }
}

__global__ void test(float * input, float * output, float *aux, int len) {
        // Load a segment of the input vector into shared memory
        __shared__ float scan_array[BLOCK_SIZE << 1];
            unsigned int t = threadIdx.x, start = 2 * blockIdx.x * BLOCK_SIZE;
                if (start + t < len)
                           scan_array[t] = input[start + t];
                    else
                               scan_array[t] = 0;
                        if (start + BLOCK_SIZE + t < len)
                                   scan_array[BLOCK_SIZE + t] = input[start + BLOCK_SIZE + t];
                            else
                                       scan_array[BLOCK_SIZE + t] = 0;
                                __syncthreads();

                                    // Reduction
                                    int stride;
                                        for (stride = 1; stride <= BLOCK_SIZE; stride <<= 1) {
                                                   int index = (t + 1) * stride * 2 - 1;
                                                          if (index < 2 * BLOCK_SIZE)
                                                                        scan_array[index] += scan_array[index - stride];
                                                                 __syncthreads();
                                                                     }

                                            // Post reduction
                                            for (stride = BLOCK_SIZE >> 1; stride; stride >>= 1) {
                                                       int index = (t + 1) * stride * 2 - 1;
                                                              if (index + stride < 2 * BLOCK_SIZE)
                                                                            scan_array[index + stride] += scan_array[index];
                                                                     __syncthreads();
                                                                         }

                                                if (start + t < len)
                                                           output[start + t] = scan_array[t];
                                                    if (start + BLOCK_SIZE + t < len)
                                                               output[start + BLOCK_SIZE + t] = scan_array[BLOCK_SIZE + t];

                                                        if (aux && t == 0)
                                                                   aux[blockIdx.x] = scan_array[2 * BLOCK_SIZE - 1];
}

int main(int argc, char* argv[]) {
	if(argc!=2){
		printf("Usage %s N\n",argv[0]);
		return 1;
	}
	int N=atoi(argv[1]);
	FILE *fp = fopen("problem1.inp","r");
	int size = N * sizeof(float); 
	//allocate resources
	float *in      = (float *)malloc(size);
	float *out     = (float *)malloc(size); 
	float *cuda_out= (float *)malloc(size);
	float *d_in, *d_out, * tmp;
    float * deviceAuxScannedArray;
    cudaMalloc(&d_in, size);
    cudaMalloc(&d_out, size);
    cudaMalloc(&tmp, (BLOCK_SIZE << 1) * sizeof(float));
    cudaMalloc(&deviceAuxScannedArray, (BLOCK_SIZE << 1) * sizeof(float));
    float time = 0.f;
	initializeArray(fp,in, N);
	// Your code here
    cudaEvent_t start, end;
    cudaEventCreate(&start);
    cudaEventCreate(&end);
    cudaEventRecord(start, 0);
    
    cudaMemcpy(d_in, in, size, cudaMemcpyHostToDevice);
    int block_num = N / BLOCK_SIZE;
    if(block_num == 0) block_num++;
    test<<<block_num, BLOCK_SIZE>>>(d_in, d_out, tmp, N);
    cudaDeviceSynchronize();
    test<<<dim3(1,1,1), BLOCK_SIZE>>>(tmp, deviceAuxScannedArray, NULL, BLOCK_SIZE << 1);
    cudaDeviceSynchronize();
    fixup<<<N/BLOCK_SIZE, BLOCK_SIZE>>>(d_out, deviceAuxScannedArray, N);
    cudaDeviceSynchronize();
    cudaMemcpy(cuda_out, d_out, size, cudaMemcpyDeviceToHost);
	cudaEventRecord(end, 0);
    cudaEventSynchronize(end);
    cudaEventElapsedTime(&time, start, end);
    inclusiveScan_SEQ(in, out,N);
	int nDiffs = checkResults(out, cuda_out,N);

	//if(nDiffs)printf("Test Failed\n"); // This should never print
	printf("%d\n%f\n%f\n",N,cuda_out[N-1],time);



	//free resources 
	free(in); free(out); free(cuda_out);
	return 0;
}