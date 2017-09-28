//gcc -ftree-vectorize -fopt-info-vec -O3 problem3b.cpp --std=c++14 -lstdc++
//problem3b.cpp note: loop vectorized
//Since vector length is 8 bytes and single-precision float size is 4 bytes, addition of the first two elements can be vectorized.
#include <iostream>

using namespace std;

int main(){
	const int rows = 96;
	const int cols = 209;
	int length = rows*cols;
	float *c = new float [length];

	float a[rows][cols] = {0};
	float b[rows][cols] = {0};
	
	float *pa = &a[0][0];
	float *pb = &b[0][0];
	
	
	for(int i = 0; i < length; i++){
		
		c[i] = pa[i]+pb[i];
	}
	cout <<"hello"<<endl;
	return 0;
}