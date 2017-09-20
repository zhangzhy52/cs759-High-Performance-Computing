#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <unistd.h>
#include <cstdlib>
#include <string>
#include <time.h>
#include <algorithm>
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
   



    ifstream infile("problem1.in");
    ofstream outfile("problem1.out");
    int totalNum = 0;
    if (argc == 1)
    {


        if (infile.is_open() )
        {
            infile >> totalNum;

            int *array = new int[totalNum];
 //           random (array, n);

            for (int i = 0 ; i < totalNum; i++)
                infile >> array[i];
            gettimeofday(&t0, NULL);
            sort(array, array + totalNum);
            gettimeofday(&t1, NULL);

            for (int i = 0; i < totalNum; i++ )
                outfile << array[i]  <<endl;
        }
        else cout << "Unable to open file";
    }
    if (argc == 2 ){
    	totalNum = stoi(argv[1]);
    	
    	
    	int *a = new int[totalNum];
    	random(a,totalNum);
    	gettimeofday(&t0, NULL);
		sort(a, a + totalNum);
		gettimeofday(&t1, NULL);
		for (int i = 0; i < totalNum; i++ )
			outfile << a[i]  <<endl;

    }



    cout << totalNum << endl;





    long elapsed = (t1.tv_sec-t0.tv_sec)*1000000 + t1.tv_usec-t0.tv_usec;
    cout << elapsed/1000 << endl;




	return 0;


}






