//Anthony Briceño
//Alex Carpio
#include <iostream>

#include <vector>
using namespace std;

bool vecinos(vector<vector<char>>&A, int x, int y, int N, int M) {
	int contador = -1;
	for (int i = -1; i < 2; i++) {
		for (int j = -1; j < 2; j++) {
			if (y + i >= 0 && x + j >= 0 && x + j < N && y+i < M) {
				if (A[x + j][y + i] == 'X') contador++;
			}
		}
	}
	if (contador > 1 && contador < 3) return true;
	if (A[x][y] == '_' && contador > 1) return true;
	return false;
}

int main() {
	int N;
	int M;
	cout << "Ingrese N: "; cin >> N;
	cout << "Ingrese M: "; cin >> M;
	vector<vector<char>> celulas;

	for (int i = 0; i < N; i++) {
		vector<char> aux;
		for (int j = 0; j < M; j++) {
			aux.push_back('_');
		}
		celulas.push_back(aux);
	}

	celulas[4][4] = 'X';
	celulas[4][5] = 'X';
	celulas[4][6] = 'X';
	celulas[3][6] = 'X';
	celulas[2][6] = 'X';
	
	bool continuar=true;
	int iter = 0;
	while (continuar) {
		cout << "=====> Iteracion " << iter << endl;
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < M; j++) {
				cout << celulas[i][j];
			}
			cout << "\n";
		}
		cout << "\n Continuar juego?(1:yes, 0:no):"; cin >> continuar;
		vector<vector<char>> aux = celulas;
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < M; j++) {
				if (vecinos(aux, i, j, N, M)) celulas[i][j] = 'X';
				else celulas[i][j] = '_';
			}
		}
		iter++;
	}

	return 0;
}
