#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/scan.h>
#include <iostream>

void init_vec(FILE* fp, thrust::host_vector<float>& hv, int n){
	for(int i = 0; i < n; i++){
        int r = fscanf(fp, "%f", &hv[i]);
		if(r == EOF){
			rewind(fp);
		}
	}
}

float reduce_host(thrust::host_vector<float>& in) {
	float sum = 0.0f;
	for (int i = 0; i < in.size(); i++) 
		sum += in[i];
    return sum;
}

int main(int argc, char* argv[]){

    if(argc != 2){
        printf("Usage %s N\n",argv[0]);
        return 1;
    }
    int N = atoi(argv[1]);
    FILE *fp = fopen("problem1.inp", "r");
    thrust::host_vector<float> h_in(N);
    init_vec(fp, h_in, N);

    thrust::device_vector<float> d_in = h_in;

    //start inclusive timing
    float time;
    cudaEvent_t startIn, stopIn;
    cudaEventCreate(&startIn);
    cudaEventCreate(&stopIn);
    cudaEventRecord(startIn, 0);	

    float res_thrust = thrust::reduce(thrust::device, d_in.begin(), d_in.end());

    //stop inclusive timing
    cudaEventRecord(stopIn, 0);
    cudaEventSynchronize(stopIn);
    cudaEventElapsedTime(&time, startIn, stopIn);
    cudaEventDestroy(startIn);
    cudaEventDestroy(stopIn);


    std::cout << N << "\n"
              << res_thrust << "\n"
              << time << "\n";


    return 0;
}
    


