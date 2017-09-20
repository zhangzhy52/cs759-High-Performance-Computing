#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <unistd.h>
#include <cstdlib>
#include <string>
#include <time.h>
#include <cmath>
using namespace std;

	void random (int a[], int n)
	{
		int i = 0;
		
		while (i < n)
			a[i++] = rand()%21 -10;
	}

	


int main(int argc, char *argv[] ){
	struct timeval t0;
    struct timeval t1;
    long elapsed;
   	srand( (unsigned) time (NULL));
// 5 - 12 ; -10 to 10
   	for (int i = 5; i < 13; i++)
   	{
   		int totalNum = pow(2, i);	
   		int *array = new int[totalNum];
   		random (array, totalNum);

        int *out = new int[totalNum];
           
        out [0] = 0;

        gettimeofday(&t0, NULL);

        for (int i = 1; i < totalNum ; i++){
            out [i] = out[i-1] + array[i];
         }
        gettimeofday(&t1, NULL);

        elapsed= (t1.tv_sec-t0.tv_sec)*1000000 + t1.tv_usec-t0.tv_usec;
    	cout << elapsed/1000 << endl;
   	}
  





    




	return 0;


}






