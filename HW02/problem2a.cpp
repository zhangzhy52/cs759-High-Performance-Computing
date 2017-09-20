#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <unistd.h>
#include <cstdlib>
#include <string>
#include <time.h>

using namespace std;

	void random (int a[], int n)
	{
		int i = 0;
		srand( (unsigned) time (NULL));
		while (i < n)
			a[i++] = rand();
	}

	


int main(int argc, char *argv[] ){
	struct timeval t0;
    struct timeval t1;
    int output = 0;



    ifstream infile("problem2.in");
    ofstream outfile("problem2.out");
    int totalNum = 0;
    if (argc == 1)
    {


        if (infile.is_open() )
        {
            infile >> totalNum;

            int *array = new int[totalNum];
            int *out = new int[totalNum];
 //           random (array, n);

            for (int i = 0 ; i < totalNum; i++)
                infile >> array[i];
            out [0] = 0;

            gettimeofday(&t0, NULL);

            for (int i = 1; i < totalNum ; i++){
                out [i] = out[i-1] + array[i];
             }
            gettimeofday(&t1, NULL);

            for (int i = 0; i < totalNum; i++ )
                outfile << out[i]  <<endl;
            output = out[totalNum - 1];
        }
        else cout << "Unable to open file";
    }
    if (argc == 2 ){
    	totalNum = stoi(argv[1]);
    	
    	
    	int *a = new int[totalNum];
        int *out = new int[totalNum];
    	random(a,totalNum);
        out[0] = 0;

    	gettimeofday(&t0, NULL);
		for (int i = 1; i < totalNum ; i++){
                out [i] = out[i-1] + a[i];
             }
        gettimeofday(&t1, NULL);     
        for (int i = 0; i < totalNum; i++ )
                outfile << out[i]  <<endl;
        output = out[totalNum - 1];

    }



    cout << totalNum << endl;


    cout<< output <<endl;


    long elapsed = (t1.tv_sec-t0.tv_sec)*1000000 + t1.tv_usec-t0.tv_usec;
    cout << elapsed/1000 << endl;





	return 0;


}






