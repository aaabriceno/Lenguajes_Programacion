//Gramatica 2 del PDF
#include <cctype>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;

enum class TipoDeToken {
    Numero,
    Suma,
    Resta,
    Multiplicacion,
    Division,
    ParentesisIzquierdo,
    ParentesisDerecho,
    FinDeEntrada
};

struct TokenLexico {
    TipoDeToken tipo;
    string lexema;
    long long valorNumerico;
    size_t posicionInicial;
};

class AnalizadorLexico {
public:
    explicit AnalizadorLexico(const string& expresionOriginal)
        : expresionAritmetica(expresionOriginal), indiceActual(0) {}

    vector<TokenLexico> tokenizarExpresion() {
        vector<TokenLexico> tokensEncontrados;

        while (indiceActual < expresionAritmetica.size()) {
            const char caracterActual = expresionAritmetica[indiceActual];

            if (isspace(static_cast<unsigned char>(caracterActual))) {
                ++indiceActual;
                continue;
            }

            if (isdigit(static_cast<unsigned char>(caracterActual))) {
                tokensEncontrados.push_back(leerNumeroCompleto());
                continue;
            }

            tokensEncontrados.push_back(crearTokenDeSimbolo(caracterActual));
            ++indiceActual;
        }

        tokensEncontrados.push_back({
            TipoDeToken::FinDeEntrada,
            "",
            0,
            expresionAritmetica.size()
        });

        return tokensEncontrados;
    }

private:
    TokenLexico leerNumeroCompleto() {
        const size_t posicionInicialDelNumero = indiceActual;

        while (indiceActual < expresionAritmetica.size() &&
               isdigit(static_cast<unsigned char>(expresionAritmetica[indiceActual]))) {
            ++indiceActual;
        }

        const string lexemaDelNumero =
            expresionAritmetica.substr(posicionInicialDelNumero, indiceActual - posicionInicialDelNumero);

        return {
            TipoDeToken::Numero,
            lexemaDelNumero,
            stoll(lexemaDelNumero),
            posicionInicialDelNumero
        };
    }

    TokenLexico crearTokenDeSimbolo(char simboloEncontrado) const {
        switch (simboloEncontrado) {
            case '+':
                return {TipoDeToken::Suma, "+", 0, indiceActual};
            case '-':
                return {TipoDeToken::Resta, "-", 0, indiceActual};
            case '*':
                return {TipoDeToken::Multiplicacion, "*", 0, indiceActual};
            case '/':
                return {TipoDeToken::Division, "/", 0, indiceActual};
            case '(':
                return {TipoDeToken::ParentesisIzquierdo, "(", 0, indiceActual};
            case ')':
                return {TipoDeToken::ParentesisDerecho, ")", 0, indiceActual};
            default: {
                ostringstream mensajeDeError;
                mensajeDeError << "Caracter no valido '" << simboloEncontrado
                               << "' en la posicion " << indiceActual + 1 << ".";
                throw runtime_error(mensajeDeError.str());
            }
        }
    }

    string expresionAritmetica;
    size_t indiceActual;
};

class AnalizadorSintactico {
public:
    explicit AnalizadorSintactico(const vector<TokenLexico>& tokensDeEntrada)
        : tokens(tokensDeEntrada), indiceDelTokenActual(0) {}

    long long analizarYEvaluarExpresion() {
        const long long resultadoDeLaExpresion = analizarExpresion();
        verificarFinCompletoDeLaEntrada();
        return resultadoDeLaExpresion;
    }

private:
    long long analizarExpresion() {
        long long valorAcumuladoDeLaExpresion = analizarTermino();

        while (tokenActual().tipo == TipoDeToken::Suma ||
               tokenActual().tipo == TipoDeToken::Resta) {
            const TipoDeToken operadorAditivo = tokenActual().tipo;
            avanzarAlSiguienteToken();

            const long long valorDelSiguienteTermino = analizarTermino();

            if (operadorAditivo == TipoDeToken::Suma) {
                valorAcumuladoDeLaExpresion += valorDelSiguienteTermino;
            } else {
                valorAcumuladoDeLaExpresion -= valorDelSiguienteTermino;
            }
        }

        return valorAcumuladoDeLaExpresion;
    }

    long long analizarTermino() {
        long long valorAcumuladoDelTermino = analizarFactor();

        while (tokenActual().tipo == TipoDeToken::Multiplicacion ||
               tokenActual().tipo == TipoDeToken::Division) {
            const TipoDeToken operadorMultiplicativo = tokenActual().tipo;
            avanzarAlSiguienteToken();
            const long long valorDelSiguienteFactor = analizarFactor();

            if (operadorMultiplicativo == TipoDeToken::Multiplicacion) {
                valorAcumuladoDelTermino *= valorDelSiguienteFactor;
            } else {
                if (valorDelSiguienteFactor == 0) {
                    throw construirErrorSintactico("No se puede dividir entre cero.");
                }
                valorAcumuladoDelTermino /= valorDelSiguienteFactor;
            }
        }

        return valorAcumuladoDelTermino;
    }

    long long analizarFactor() {
        if (tokenActual().tipo == TipoDeToken::ParentesisIzquierdo) {
            avanzarAlSiguienteToken();
            const long long valorDeLaSubexpresion = analizarExpresion();
            consumirTokenEsperado(TipoDeToken::ParentesisDerecho, "Se esperaba ')' para cerrar la subexpresion.");
            return valorDeLaSubexpresion;
        }

        if (tokenActual().tipo == TipoDeToken::Numero) {
            const long long valorDelNumero = tokenActual().valorNumerico;
            avanzarAlSiguienteToken();
            return valorDelNumero;
        }

        throw construirErrorSintactico("Se esperaba un numero o un parentesis de apertura.");
    }

    void consumirTokenEsperado(TipoDeToken tipoEsperado, const string& mensajeDeError) {
        if (tokenActual().tipo != tipoEsperado) {
            throw construirErrorSintactico(mensajeDeError);
        }
        avanzarAlSiguienteToken();
    }

    void verificarFinCompletoDeLaEntrada() {
        if (tokenActual().tipo != TipoDeToken::FinDeEntrada) {
            throw construirErrorSintactico("Hay simbolos adicionales despues de una expresion valida.");
        }
    }

    [[nodiscard]] const TokenLexico& tokenActual() const {
        return tokens[indiceDelTokenActual];
    }

    void avanzarAlSiguienteToken() {
        if (indiceDelTokenActual < tokens.size() - 1) {
            ++indiceDelTokenActual;
        }
    }

    [[nodiscard]] runtime_error construirErrorSintactico(const string& mensajeBase) const {
        ostringstream mensajeCompleto;
        mensajeCompleto << mensajeBase;

        if (tokenActual().tipo == TipoDeToken::FinDeEntrada) {
            mensajeCompleto << " Fin de entrada en la posicion " << tokenActual().posicionInicial + 1 << ".";
        } else {
            mensajeCompleto << " Token encontrado: '" << tokenActual().lexema
                            << "' en la posicion " << tokenActual().posicionInicial + 1 << ".";
        }

        return runtime_error(mensajeCompleto.str());
    }

    const vector<TokenLexico>& tokens;
    size_t indiceDelTokenActual;
};

int main() {
    cout << "Gramatica elegida: <expr> -> <expr> <opsuma> <term> | <term>\n";
    cout << "Ingrese una expresion por linea. Finalice con EOF (Ctrl+D en Linux/macOS, Ctrl+Z en Windows).\n\n";

    string expresionIngresada;
    int numeroDeLineaEvaluada = 0;

    while (getline(cin, expresionIngresada)) {
        ++numeroDeLineaEvaluada;

        if (expresionIngresada.find_first_not_of(" \t\r\n") == string::npos) {
            continue;
        }

        try {
            AnalizadorLexico analizadorLexico(expresionIngresada);
            const vector<TokenLexico> tokensDeLaExpresion = analizadorLexico.tokenizarExpresion();

            AnalizadorSintactico analizadorSintactico(tokensDeLaExpresion);
            const long long valorCalculado = analizadorSintactico.analizarYEvaluarExpresion();

            cout << "Linea " << numeroDeLineaEvaluada << ": PERTENECE | valor = "
                      << valorCalculado << '\n';
        } catch (const exception& excepcionDetectada) {
            cout << "Linea " << numeroDeLineaEvaluada << ": NO PERTENECE | razon = "
                      << excepcionDetectada.what() << '\n';
        }
    }

    return 0;
}
