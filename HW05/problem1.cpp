#include <stdio.h>
#include <omp.h>
#include <vector>
#include <stdlib.h>
#include <string.h>

using namespace std;

#define MAX_ITER 10

int N;

void foo(char* buffer, size_t size) {
    int count_of_reads = 0;
    int count = 1;
    int nthreads;
    int * result_count = (int*) malloc(sizeof(int) * N * 7);
    for(int i = 0; i < N * 7; i++) result_count[i] = 0;

	double start_time = omp_get_wtime();
	char * nums[N];
	for(int i = 0; i < N; i++) {
		nums[i] = (char*) malloc(sizeof(char) * 1);
	}

	for(int iter = 0; iter < MAX_ITER; iter++){
	    #pragma omp parallel for num_threads(N)
	    for(int i = 0; i < size; i++) {
	        if(buffer[i] == '\n') continue;
	        int thread_num = omp_get_thread_num();
	        strncpy(nums[thread_num], &buffer[i], 1);
	        int cur = atoi(nums[thread_num]);
	        result_count[thread_num * 7 + cur]++;
	    }
	}
	for(int i = 7; i < N * 7; i++) {
		result_count[i % 7] += result_count[i];
	}
  for(int i = 0; i < 7; i++) {
    result_count[i] /= MAX_ITER;
  }
	double end_time = omp_get_wtime();
	double duration = (end_time - start_time) * 1000 / MAX_ITER;

    for(int i = 0; i < 7; i++) {
    	printf("%d\n", result_count[i]);
    }
    printf("%d\n", N);
    printf("%lf\n", duration);
}

int main (int argc, char * argv[]) {
  FILE * pFile;
  long lSize;
  char * buffer;
  size_t result;

  N = atoi(argv[1]);

  pFile = fopen ( "picture.inp" , "rb" );
  if (pFile==NULL) {fputs ("File error",stderr); exit (1);}

  // obtain file size:
  fseek (pFile , 0 , SEEK_END);
  lSize = ftell (pFile);
  rewind (pFile);

  // allocate memory to contain the whole file:
  buffer = (char*) malloc (sizeof(char)*lSize);
  if (buffer == NULL) {fputs ("Memory error",stderr); exit (2);}

  // copy the file into the buffer:
  result = fread (buffer,1,lSize,pFile);
  if (result != lSize) {fputs ("Reading error",stderr); exit (3);}

  /* the whole file is now loaded in the memory buffer. */
  foo(buffer, result);
  // terminate

  fclose (pFile);
  free (buffer);
  return 0;
}