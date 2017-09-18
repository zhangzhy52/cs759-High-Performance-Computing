#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main()
{
    string line;
    ifstream myfile("problem1.txt");
    if (myfile.is_open())
    {
        getline(myfile,line);
        if (4 < line.length())
            cout << line.substr(line.length() - 4) <<endl;
        else
            cout << "Not enough Number\n";

    }
    else cout<< "File error";
    return 0;
}
