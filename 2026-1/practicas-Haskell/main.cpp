#include <iostream>
using namespace std;

void incrementa (int& x, int& y){
    if (x > y || ++x > 5){
        x = x++ + ++y;
        x++;
        ++x;
        y++;
    }
    else{
        x = x + y;
        ++x;
    }
}

int main(){
    int a [] = {2,4,6};
    for (int i = 0; i < 3; i++){
        incrementa(a[ i ], a[ 1 ]);
        cout << a [ i ] << "\n";
    }
    return 0;
}