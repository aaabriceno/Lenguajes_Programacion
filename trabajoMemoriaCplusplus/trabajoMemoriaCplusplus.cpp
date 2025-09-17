#include <iostream>
using namespace std;

class Punto {
public:
    float x, y;
    Punto(float a, float b) : x(a), y(b) {}
    
    float operator*(const Punto& p) const {
        float dx = x - p.x;
        float dy = y - p.y;
        return dx * dx + dy * dy;
    }
};

int main() {
    Punto a(2, 3);
    //cout << "Direccion de a: " << &a << endl;
    //cout << "Direccion de a.x: " << &(a.x) << endl;
    //cout << "Direccion de a.y: " << &(a.y) << endl;
    Punto b(5, 7);
    //cout << "Direccion de b: " << &b << endl;
    
    float d2 = a * b;
    cout << "Distancia^2 entre puntos: " << d2 << endl;
    return 0;
}