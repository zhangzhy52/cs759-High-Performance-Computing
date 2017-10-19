#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

#define BUF_SIZE 1024
#define MAT_SIZE 1024
#define TILE_STEP 32

int THREAD_NUM;
void transpose(double *A, double *B, int n) {
    int i,j;
    for(i=0; i<n; i++) {
        for(j=0; j<n; j++) {
            B[j*n+i] = A[i*n+j];
        }
    }
}

void gemmT(double *A, double *B, double *C, int n) 
{   
    int i, j, k;
    double *B2;
    B2 = (double*)malloc(sizeof(double)*n*n);
    transpose(B,B2, n);
    for (i = 0; i < n; i++) { 
        for (j = 0; j < n; j++) {
            double dot  = 0;
            for (k = 0; k < n; k++) {
                dot += A[i*n+k]*B2[j*n+k];
            } 
            C[i*n+j ] = dot;
        }
    }
    free(B2);
}

void gemmT_omp2(double *A, double *B, double *C, int n) 
{   
    double *B2;
    B2 = (double*)malloc(sizeof(double)*n*n);
    transpose(B,B2, n);
    #pragma omp parallel num_threads(THREAD_NUM)
    {
        int i, j, k;
        #pragma omp for
        for (i = 0; i < n; i++) { 
            for (j = 0; j < n; j++) {
                double dot  = 0;
                for (k = 0; k < n; k++) {
                    dot += A[i*n+k]*B2[j*n+k];
                } 
                C[i*n+j ] = dot;
            }
        }

    }
    free(B2);
}


void gemmT_omp(double *A, double *B, double *C, int n) 
{   
    double *B2;
    int step = TILE_STEP;
    B2 = (double*)malloc(sizeof(double)*n*n);
    transpose(B,B2,n);

    bool * arr = (bool*)malloc(sizeof(bool) * n * n);
    #pragma omp parallel num_threads(THREAD_NUM)
    {
        int i, j, k, ii, jj, kk;
        #pragma omp for collapse(3)
        for (i = 0; i < n; i += step) { 
            for (j = 0; j < n; j += step) {
                for (k = 0; k < n; k += step) {

                    for (ii = i; ii < i + step; ii++) {
                        for (jj = j; jj < j + step; jj++) {
                            for (kk = k; kk < k + step; kk++) {
                                C[ii * n + jj] += A[ii * n + kk] * B2[jj * n + kk];
                            }
                        }
                    }

                } 
            }
        }
    }
    free(B2);
}

void read_from_file(double * A, double * B) {
    size_t buf_size = BUF_SIZE;
    FILE * fpA, * fpB;
    fpA = fopen("inputA.inp", "r");
    fpB = fopen("inputB.inp", "r");
    char * buf = (char*)malloc(sizeof(char) * BUF_SIZE);
    int count_A = 0, count_B = 0;
    int read;
    while((read = getline(&buf, &buf_size, fpA)) != -1) {
        double cur = atof(buf);
        A[count_A++] = cur;
    }

    while((read = getline(&buf, &buf_size, fpB)) != -1) {
        double cur = atof(buf);
        B[count_B++] = cur;
    }
}

int main(int argc, char * argv[]) {
    int i, n;
    double *A, *B, *C, dtime;
    double *A2, *B2, *C2;
    THREAD_NUM = atoi(argv[1]);

    n=MAT_SIZE;
    A = (double*)malloc(sizeof(double)*n*n);
    B = (double*)malloc(sizeof(double)*n*n);
    C = (double*)malloc(sizeof(double)*n*n);
    A2 = (double*)malloc(sizeof(double)*n*n);
    B2 = (double*)malloc(sizeof(double)*n*n);
    C2 = (double*)malloc(sizeof(double)*n*n);
    memset(C, sizeof(double) *n *n, 0);
    read_from_file(A, B);
    memcpy(A2, A, sizeof(double) * n * n);
    memcpy(B2, B, sizeof(double) * n * n);

    // dtime = omp_get_wtime();
    // gemmT_omp2(A2,B2,C2, n);
    // dtime = omp_get_wtime() - dtime;
    // printf("%f\n", C2[n * n- 1]);
    // printf("%f\n", dtime);

    dtime = omp_get_wtime();
    gemmT_omp(A,B,C, n);
    dtime = omp_get_wtime() - dtime;

    printf("%f\n", C[n * n- 1]);
    printf("%f\n", dtime);
    printf("%d\n", THREAD_NUM);
    return 0;

}