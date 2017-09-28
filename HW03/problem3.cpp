#include <iostream>
using namespace std;
int main(){

	int a[2][3] = {};
	for (int row= 0; row < 3; row++)
		for (int col = 0; col < 4; col++){
			cout << &a[row][col]<<endl;
		}
	return 0;
}

// The address is contiguous.

