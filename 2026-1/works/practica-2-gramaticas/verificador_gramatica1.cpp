#include <cctype>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
// #include <unordered_map>
#include <vector>
using namespace std;

enum class TipoDeTokenGramaticaUno {
    Identificador,
    Numero,
    Suma,
    Resta,
    Multiplicacion,
    Division,
    ParentesisIzquierdo,
    ParentesisDerecho,
    FinDeEntrada
};

struct TokenDeGramaticaUno {
    TipoDeTokenGramaticaUno tipo;
    string lexema;
    long long valorNumerico; // Ya no se usa para evaluar, pero se conserva para no alterar la estructura del token.
    size_t posicionInicial;
};

class AnalizadorLexicoGramaticaUno {
public:
    explicit AnalizadorLexicoGramaticaUno(const string& expresionOriginal)
        : expresionAValidar(expresionOriginal), indiceActual(0) {}

    vector<TokenDeGramaticaUno> tokenizarExpresion() {
        vector<TokenDeGramaticaUno> tokensReconocidos;

        while (indiceActual < expresionAValidar.size()) {
            const char caracterActual = expresionAValidar[indiceActual];

            if (isspace(static_cast<unsigned char>(caracterActual))) {
                ++indiceActual;
                continue;
            }

            if (isdigit(static_cast<unsigned char>(caracterActual))) {
                tokensReconocidos.push_back(leerNumeroPermitido());
                continue;
            }

            if (isalpha(static_cast<unsigned char>(caracterActual))) {
                tokensReconocidos.push_back(leerIdentificadorPermitido());
                continue;
            }

            tokensReconocidos.push_back(crearTokenDeSimbolo(caracterActual));
            ++indiceActual;
        }

        tokensReconocidos.push_back({
            TipoDeTokenGramaticaUno::FinDeEntrada,
            "",
            0,
            expresionAValidar.size()
        });

        return tokensReconocidos;
    }

private:
    TokenDeGramaticaUno leerNumeroPermitido() {
        const size_t posicionInicialDelNumero = indiceActual;

        while (indiceActual < expresionAValidar.size() &&
               isdigit(static_cast<unsigned char>(expresionAValidar[indiceActual]))) {
            ++indiceActual;
        }

        const string lexemaDelNumero =
            expresionAValidar.substr(posicionInicialDelNumero, indiceActual - posicionInicialDelNumero);
        const long long valorDelNumero = stoll(lexemaDelNumero);

        if (valorDelNumero < 0 || valorDelNumero > 10) {
            ostringstream mensajeDeError;
            mensajeDeError << "El numero '" << lexemaDelNumero
                           << "' no pertenece a <numero>; solo se permite del 0 al 10.";
            throw runtime_error(mensajeDeError.str());
        }

        return {
            TipoDeTokenGramaticaUno::Numero,
            lexemaDelNumero,
            valorDelNumero,
            posicionInicialDelNumero
        };
    }

    TokenDeGramaticaUno leerIdentificadorPermitido() {
        const size_t posicionInicialDelIdentificador = indiceActual;

        while (indiceActual < expresionAValidar.size() &&
               isalpha(static_cast<unsigned char>(expresionAValidar[indiceActual]))) {
            ++indiceActual;
        }

        const string lexemaDelIdentificador =
            expresionAValidar.substr(posicionInicialDelIdentificador,
                                     indiceActual - posicionInicialDelIdentificador);

        if (lexemaDelIdentificador != "suma" &&
            lexemaDelIdentificador != "total" &&
            lexemaDelIdentificador != "resta") {
            ostringstream mensajeDeError;
            mensajeDeError << "El identificador '" << lexemaDelIdentificador
                           << "' no pertenece a <ident>; solo se permite suma, total o resta.";
            throw runtime_error(mensajeDeError.str());
        }

        return {
            TipoDeTokenGramaticaUno::Identificador,
            lexemaDelIdentificador,
            0,
            posicionInicialDelIdentificador
        };
    }

    TokenDeGramaticaUno crearTokenDeSimbolo(char simboloEncontrado) const {
        switch (simboloEncontrado) {
            case '+':
                return {TipoDeTokenGramaticaUno::Suma, "+", 0, indiceActual};
            case '-':
                return {TipoDeTokenGramaticaUno::Resta, "-", 0, indiceActual};
            case '*':
                return {TipoDeTokenGramaticaUno::Multiplicacion, "*", 0, indiceActual};
            case '/':
                return {TipoDeTokenGramaticaUno::Division, "/", 0, indiceActual};
            case '(':
                return {TipoDeTokenGramaticaUno::ParentesisIzquierdo, "(", 0, indiceActual};
            case ')':
                return {TipoDeTokenGramaticaUno::ParentesisDerecho, ")", 0, indiceActual};
            default: {
                ostringstream mensajeDeError;
                mensajeDeError << "Caracter no valido '" << simboloEncontrado
                               << "' en la posicion " << indiceActual + 1 << ".";
                throw runtime_error(mensajeDeError.str());
            }
        }
    }

    string expresionAValidar;
    size_t indiceActual;
};

class AnalizadorSintacticoGramaticaUno {
public:
    // Version anterior con evaluacion:
    // AnalizadorSintacticoGramaticaUno(
    //     const vector<TokenDeGramaticaUno>& tokensDeEntrada,
    //     const unordered_map<string, long long>& valoresDeIdentificadores)
    //     : tokens(tokensDeEntrada),
    //       valoresAsignadosAIdentificadores(valoresDeIdentificadores),
    //       indiceDelTokenActual(0) {}
    AnalizadorSintacticoGramaticaUno(const vector<TokenDeGramaticaUno>& tokensDeEntrada)
        : tokens(tokensDeEntrada), indiceDelTokenActual(0) {}

    // Version anterior con evaluacion:
    // long long analizarYEvaluarExpresion() {
    //     const long long resultadoDeLaExpresion = analizarExpresion();
    //     verificarFinCompletoDeLaEntrada();
    //     return resultadoDeLaExpresion;
    // }
    void analizarExpresionCompleta() {
        analizarExpresion();
        verificarFinCompletoDeLaEntrada();
    }

private:
    // Version anterior con evaluacion:
    // long long analizarExpresion() {
    //     long long valorDelPrimerTermino = analizarTermino();
    void analizarExpresion() {
        analizarTermino();

        if (tokenActual().tipo == TipoDeTokenGramaticaUno::Suma ||
            tokenActual().tipo == TipoDeTokenGramaticaUno::Resta) {
            avanzarAlSiguienteToken();
            analizarTermino();
        }
    }

    // Version anterior con evaluacion:
    // long long analizarTermino() {
    //     long long valorDelPrimerFactor = analizarFactor();
    void analizarTermino() {
        analizarFactor();

        if (tokenActual().tipo == TipoDeTokenGramaticaUno::Multiplicacion ||
            tokenActual().tipo == TipoDeTokenGramaticaUno::Division) {
            avanzarAlSiguienteToken();
            analizarFactor();
        }
    }

    // Version anterior con evaluacion:
    // long long analizarFactor() {
    void analizarFactor() {
        if (tokenActual().tipo == TipoDeTokenGramaticaUno::ParentesisIzquierdo) {
            avanzarAlSiguienteToken();
            analizarExpresion();
            consumirTokenEsperado(
                TipoDeTokenGramaticaUno::ParentesisDerecho,
                "Se esperaba ')' para cerrar la subexpresion.");
            return;
        }

        if (tokenActual().tipo == TipoDeTokenGramaticaUno::Numero) {
            avanzarAlSiguienteToken();
            return;
        }

        if (tokenActual().tipo == TipoDeTokenGramaticaUno::Identificador) {
            avanzarAlSiguienteToken();
            return;
        }

        throw construirErrorSintactico("Se esperaba un identificador permitido, un numero o '('.");
    }

    void consumirTokenEsperado(
        TipoDeTokenGramaticaUno tipoEsperado,
        const string& mensajeDeError) {
        if (tokenActual().tipo != tipoEsperado) {
            throw construirErrorSintactico(mensajeDeError);
        }
        avanzarAlSiguienteToken();
    }

    void verificarFinCompletoDeLaEntrada() {
        if (tokenActual().tipo != TipoDeTokenGramaticaUno::FinDeEntrada) {
            throw construirErrorSintactico("Hay simbolos adicionales despues de una expresion valida.");
        }
    }

    [[nodiscard]] const TokenDeGramaticaUno& tokenActual() const {
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

        if (tokenActual().tipo == TipoDeTokenGramaticaUno::FinDeEntrada) {
            mensajeCompleto << " Fin de entrada en la posicion " << tokenActual().posicionInicial + 1 << ".";
        } else {
            mensajeCompleto << " Token encontrado: '" << tokenActual().lexema
                            << "' en la posicion " << tokenActual().posicionInicial + 1 << ".";
        }

        return runtime_error(mensajeCompleto.str());
    }

    const vector<TokenDeGramaticaUno>& tokens;
    // const unordered_map<string, long long>& valoresAsignadosAIdentificadores;
    size_t indiceDelTokenActual;
};

int main() {
    // Version anterior con evaluacion:
    // const unordered_map<string, long long> valoresDeVariablesPermitidas = {
    //     {"suma", 8},
    //     {"total", 4},
    //     {"resta", 3}
    // };

    cout << "Gramatica 1:\n";
    cout << "<expr>   -> <term> + <term> | <term> - <term> | <term>\n";
    cout << "<term>   -> <factor> * <factor> | <factor> / <factor> | <factor>\n";
    cout << "<factor> -> <ident> | <numero> | ( <expr> )\n";
    cout << "<ident>  -> suma | total | resta\n";
    cout << "<numero> -> 0 | ... | 10\n\n";

    // Version anterior con evaluacion:
    // cout << "Valores usados para evaluar: suma = " << valoresDeVariablesPermitidas.at("suma")
    //           << ", total = " << valoresDeVariablesPermitidas.at("total")
    //           << ", resta = " << valoresDeVariablesPermitidas.at("resta") << "\n";
    //cout << "Modo actual: solo verificacion sintactica, sin asignar valores a suma, total y resta.\n";
    cout << "Ingrese una expresion por linea. Finalice con EOF.\n\n";

    string expresionIngresada;
    int numeroDeLineaEvaluada = 0;

    while (getline(cin, expresionIngresada)) {
        ++numeroDeLineaEvaluada;

        if (expresionIngresada.find_first_not_of(" \t\r\n") == string::npos) {
            continue;
        }

        try {
            AnalizadorLexicoGramaticaUno analizadorLexico(expresionIngresada);
            const vector<TokenDeGramaticaUno> tokensDeLaExpresion = analizadorLexico.tokenizarExpresion();

            // Version anterior con evaluacion:
            // AnalizadorSintacticoGramaticaUno analizadorSintactico(
            //     tokensDeLaExpresion,
            //     valoresDeVariablesPermitidas);
            AnalizadorSintacticoGramaticaUno analizadorSintactico(tokensDeLaExpresion);

            // Version anterior con evaluacion:
            // const long long valorCalculado = analizadorSintactico.analizarYEvaluarExpresion();
            analizadorSintactico.analizarExpresionCompleta();

            // Version anterior con evaluacion:
            // cout << "Linea " << numeroDeLineaEvaluada << ": PERTENECE | valor = "
            //           << valorCalculado << '\n';
            cout << "Linea " << numeroDeLineaEvaluada << ": PERTENECE\n";
        } catch (const exception& excepcionDetectada) {
            cout << "Linea " << numeroDeLineaEvaluada << ": NO PERTENECE | razon = "
                      << excepcionDetectada.what() << '\n';
        }
    }

    return 0;
}
