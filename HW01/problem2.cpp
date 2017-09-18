#include <iostream>
#include <string>
using namespace std;

int main(int argc, char *argv[]){
	string s;
	if (argc != 2)
		cout <<"You need a string as an input\n";
	s = argv[1];
	cout << s.length()<< "\n";
	return 0;
	}
