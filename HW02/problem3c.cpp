#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char * argv[]){



	if (argc != 3 )
		cout << "Invalid input"<< endl;

	int mSize = stoi(argv [1]);
	int fSize = stoi(argv [2]);
	ifstream infile("problem3.dat");
	int** newMAry = new int*[mSize];
	int ** fAry = new int *[fSize];


	if (infile.is_open())
	{
		int tmp = 0;
		for (int i = 0; i < mSize; i++){
			newMAry[i] = new int[mSize];

			for (int j = 0; j < mSize ; j++)
			{

				infile >> newMAry[i][ j] ;
			}
		}

		for (int i = 0; i < fSize; i++){
			fAry[i] = new int[fSize];

			for (int j = 0; j < fSize ; j++)
			{

				infile >> fAry[i][ j] ;
			}
		}

	}


	int max = -1;
	int rowIndex = -1, colIndex = -1;
	for (int i =0; i < mSize - fSize + 1; i++ )
		for (int j = 0; j < mSize - fSize + 1; j++)
	{
		int tmp = 0;
		for (int k = i; k < i+ fSize ;k++)
			for (int l = j; l < j + fSize; l++)
			{
				tmp += newMAry[k][l] * fAry[k - i][l -j];
			}
		if (tmp > max){
			max = tmp;
			rowIndex = i;
			colIndex = j;
		}
		
	}
	ofstream outfile("problem3b.dat");
	int** mAry = new int*[mSize];
	cout << rowIndex << " " << colIndex<< endl;



	return 0;
}