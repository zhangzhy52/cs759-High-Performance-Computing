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

	int divide ( int a[], int low, int high)
	{
		int pivot = a[low];
		while ( low < high){
			while (low < high && a[high] >= pivot) high--;
			a[low] = a[high];
			while ( low < high && a[low ] <= pivot) low++;
			a[high] = a[low];
		}
		a[low] = pivot;
		return low;
	}
	void quickSort(int a[], int low, int high)
	{

		if (low >= high) return;
		int mid = divide (a, low, high);
		quickSort(a, low, mid - 1);
		quickSort(a, mid + 1, high);

	}
	void quickSort(int a[], int size){
		quickSort(a, 0, size -1);
	}


int main(int argc, char *argv[] ){
	struct timeval t0;
    struct timeval t1;
   



    ifstream infile("problem1.in");
    ofstream outfile("problem1.out");
    int totalNum = 0;
   
    for (int i = 10; i < 20; i++){
    	totalNum = pow(2, i);
    	int *array = new int[totalNum];
    	random (array, totalNum);
    	gettimeofday(&t0, NULL);
		quickSort(array, totalNum);
		gettimeofday(&t1, NULL);

    	long elapsed = (t1.tv_sec-t0.tv_sec)*1000000 + t1.tv_usec-t0.tv_usec;
    	cout << elapsed/1000 << "\t";

    	gettimeofday(&t0, NULL);
        sort(array, array + totalNum);
        gettimeofday(&t1, NULL);
        elapsed = (t1.tv_sec-t0.tv_sec)*1000000 + t1.tv_usec-t0.tv_usec;
    	cout << elapsed/1000 << "\n";

    	delete[] array;

    }

     
           

	return 0;


}






