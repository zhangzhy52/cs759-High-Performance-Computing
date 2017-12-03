#include <thrust/count.h>
#include <thrust/reduce.h>
#include <thrust/iterator/zip_iterator.h>
#include <iostream>

using namespace thrust::placeholders;

int main(){

    int days[] = {0, 0, 1, 2, 5, 5, 6, 6, 7, 8, 9, 9, 9, 10, 11};
    int site[] = {2, 3, 0, 1, 1, 2, 0, 1, 2, 1, 3, 4, 0, 1, 2};
    int measurement[] = {9, 5, 6, 3, 3, 8, 2, 6, 5, 10, 9, 11, 8, 4, 1};
    const int N = 15;

    // part 1
    bool exceed_5[N];
    thrust::transform(thrust::host, 
                      measurement, 
                      measurement+N, 
                      exceed_5,
                      _1>5);
    int days_keys[N];
    int days_values[N];
    thrust::equal_to<int> binary_pred;
    thrust::pair<int*,int*> new_end;
    new_end = thrust::reduce_by_key(thrust::host, 
                                    days, 
                                    days+N, 
                                    exceed_5, 
                                    days_keys, 
                                    days_values, 
                                    binary_pred, 
                                    _1 || _2);
    int n_exceed_5  = thrust::count_if(thrust::host, 
                                       days_values, 
                                       new_end.second, 
                                       _1);
    printf("%d\n", n_exceed_5);

    // part 2
    thrust::sort_by_key(thrust::host, site, site+N, measurement);
    int new_site[N];
    int total_rainfalls[N];
    new_end = thrust::reduce_by_key(thrust::host, 
                          site, 
                          site+N, 
                          measurement, 
                          new_site, 
                          total_rainfalls);
    for(int i = 0; i < new_end.second-total_rainfalls; i++)
        printf("%d ", total_rainfalls[i]);
    printf("\n");
};
