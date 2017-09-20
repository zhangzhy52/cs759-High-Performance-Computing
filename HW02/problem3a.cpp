#include <iostream>
#include <string>
#include <sys/time.h>
#include <fstream>
#include <time.h>

using namespace std;


	void random (int a[], int n)
	{
		int i = 0;
		
		while (i < n){
			
			a[i++] = (rand() %2 ==0) ? 1 : -1;
		}
	}


int main(int argc, char * argv[]){
	srand( (unsigned) time (NULL)); 



	if (argc != 3 )
		cout << "Invalid input"<< endl;

	ofstream  outfile("problem3.dat");

	int matrixSize = stoi(argv[1]);
	int featureSize = stoi(argv[2]);

	//int* mAry = new int*[matrixSize];
	int** fAry = new int*[featureSize];
	for(int i = 0; i < matrixSize; ++i){
		int *mAry = new int[matrixSize];
		random( mAry, matrixSize);
		for (int j = 0; j < matrixSize ; j++){
			outfile << mAry[j]<< " ";	
		}
		outfile << "\n";
		delete mAry;
		
	}

	for(int i = 0; i < featureSize; ++i){
		fAry[i] = new int[featureSize];
		random( fAry[i], featureSize);
		for (int j = 0; j < featureSize ; j++){
			outfile << fAry[i][j]<< " ";	
		}
		outfile << "\n";
	}
    	

	return 0;
}