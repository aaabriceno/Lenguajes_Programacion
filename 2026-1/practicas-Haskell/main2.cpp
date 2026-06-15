#include <stdio.h>
#include <iostream>
using namespace std;

template <class T>
class pila{
    T* v;
    T* p;

    public: pila (int i){
        cout << "Crea " << i << "\n";
        v = p = new T[i];
    }

    ~pila (){
        delete [] v;
        cout << "Bye \n";
    }

    void empila(T a){
        cout << "Exp " << a << "\n"; *p++ = a;
    }

    T desempila(){
        return *--p;
    }
    
    int vacio(){
        if (v == p) return 1;
        else return 0;
    }   
};


int main(){ 
    pila <int> p(40);
    pila <char> q(30);
    p.empila(11);
    q.empila('x');
    p.empila(22);
    q.empila('y');
    p.empila(33);
    do {
        cout << p.desempila() << "\n";
    }
    while (!p.vacio());

    do {
        cout << q.desempila() << "\n";
    }
    while (!q.vacio());
    return 0;
}