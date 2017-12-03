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



void inclusive_scan_seq(thrust::host_vector<float>& in, 
                        thrust::host_vector<float>& out,
                        int n) {
	float sum = 0.0f;
	for (int i = 0; i < n; i++) {
		sum += in[i];
		out[i] = sum;
	}
}

int check_results(thrust::host_vector<float> a, 
                  thrust::host_vector<float> b,
                  int n){
    int n_diffs = 0;
    // Keeping this extra high as we have repetitive addition and sequence matters
    const float eps = .3f; 	
    for(int i = 0; i < n; i++)
        if(fabs(a[i]-b[i]) > eps) {
            n_diffs++;
            /* printf("%f %f\n",a[i],b[i]); */
        }
    return n_diffs;
}

int main(int argc, char* argv[]){

    if(argc != 2){
        printf("Usage %s N\n",argv[0]);
        return 1;
    }
    int N = atoi(argv[1]);
    FILE *fp = fopen("problem1.inp", "r");
    thrust::host_vector<float> h_in(N);
    thrust::host_vector<float> h_out_seq(N);
    thrust::host_vector<float> h_out_thrust(N);
    init_vec(fp, h_in, N);

    thrust::device_vector<float> d_in = h_in;
    thrust::device_vector<float> d_out(N);

    //start inclusive timing
    float time;
    cudaEvent_t startIn, stopIn;
    cudaEventCreate(&startIn);
    cudaEventCreate(&stopIn);
    cudaEventRecord(startIn, 0);	

    thrust::inclusive_scan(thrust::device, d_in.begin(), d_in.end(), d_out.begin());

    //stop inclusive timing
    cudaEventRecord(stopIn, 0);
    cudaEventSynchronize(stopIn);
    cudaEventElapsedTime(&time, startIn, stopIn);
    cudaEventDestroy(startIn);
    cudaEventDestroy(stopIn);

    thrust::copy(d_out.begin(), d_out.end(), h_out_thrust.begin());



    std::cout << N << "\n"
              << h_out_thrust[N-1] << "\n"
              << time << "\n";

    return 0;
}
    


