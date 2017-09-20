#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char * argv[]){



	if (argc != 3 )
		cout << "Invalid input"<< endl;
	int mSize = stoi(argv [1]);
	int fSize = stoi(argv [2]);
	ifstream infile("problem3.dat");
	int** newMAry = new int*[mSize];


	if (infile.is_open())
	{
		int tmp = 0;
		for (int i = 0; i < mSize; i++){
			newMAry[mSize - 1 - i] = new int[mSize];

			for (int j = 0; j < mSize ; j++)
			{

				infile >> newMAry[mSize - 1 - i][ j] ;
			}
		}
	}
	ofstream outfile("problem3b.dat");
	int** mAry = new int*[mSize];
	for(int i = 0; i < mSize; ++i){
		mAry[i] = new int[mSize];
		
		for (int j = 0; j < mSize ; j++){
			outfile << newMAry[i][j]<< " ";	
		}
		outfile << "\n";
		
	}



	return 0;
}