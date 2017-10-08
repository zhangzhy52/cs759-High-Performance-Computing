#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include <math.h>
#include <sys/utsname.h>

#define NUM_STEPS_EACH_INTEGER 1000

int main(int argc, char * argv[]) {
        long start = 0, end = 100 * NUM_STEPS_EACH_INTEGER;
        double sum = 0;
        int N = atoi(argv[1]);
        double start_time = omp_get_wtime();
        #pragma omp parallel for schedule(dynamic, 10) num_threads(N) reduction(+:sum)
        for(long i = start; i < end; i++) {
                double cur = (double)i / NUM_STEPS_EACH_INTEGER;
            double tmp = exp(sin(cur)) * cos(cur / 40);
            sum += tmp;
        }
        double end_time = omp_get_wtime();
        double duration = (end_time - start_time) * 1000;

        struct utsname unameData;
        uname(&unameData);

        printf("%d\n", N);
        printf("%lf\n", duration);
        printf("%s\n", unameData.nodename);

        printf("%lf\n\n", (sum / NUM_STEPS_EACH_INTEGER));
        return 0;
}
