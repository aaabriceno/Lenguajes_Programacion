#include <iostream>
#include <vector>
#include <sstream>
#include <cctype>

using namespace std;

// Estructura para representar los tokens
enum TokenType {NUMBER, OPERATOR, LPAREN, RPAREN, END, INVALID};

struct Token {
    TokenType type;
    string value;
};

// Función para tokenizar la expresión
vector<Token> tokenize(const string& expression) {
    vector<Token> tokens;
    stringstream ss(expression);
    char ch;
    
    while (ss >> ch) {
        if (isdigit(ch)) {
            string num(1, ch);
            while (ss.peek() != EOF && isdigit(ss.peek())) {
                ss >> ch;
                num += ch;
            }
            tokens.push_back({NUMBER, num});
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            tokens.push_back({OPERATOR, string(1, ch)});
        } else if (ch == '(') {
            tokens.push_back({LPAREN, "("});
        } else if (ch == ')') {
            tokens.push_back({RPAREN, ")"});
        } else if (isspace(ch)) {
            continue;
        } else {
            tokens.push_back({INVALID, string(1, ch)});
        }
    }
    tokens.push_back({END, ""});  // Marcamos el final de la expresión
    return tokens;
}

// Clase Parser que maneja la validación de la gramática
class Parser {
public:
    Parser(const vector<Token>& tokens) : tokens(tokens), pos(0) {}

    bool parse() {
        return expr() && current_token().type == END;
    }

private:
    vector<Token> tokens;
    size_t pos;

    Token current_token() {
        return tokens[pos];
    }

    void consume() {
        if (pos < tokens.size()) pos++;
    }

    bool expr() {
        return term() && expr_prime();
    }

    bool expr_prime() {
        if (current_token().type == OPERATOR && (current_token().value == "+" || current_token().value == "-")) {
            consume(); // Consume operator
            return term() && expr_prime();
        }
        return true; // Epsilon (nothing) allowed
    }

    bool term() {
        return factor() && term_prime();
    }

    bool term_prime() {
        if (current_token().type == OPERATOR && (current_token().value == "*" || current_token().value == "/")) {
            consume(); // Consume operator
            return factor() && term_prime();
        }
        return true; // Epsilon (nothing) allowed
    }

    bool factor() {
        if (current_token().type == NUMBER) {
            consume(); // Consume number
            return true;
        } else if (current_token().type == LPAREN) {
            consume(); // Consume '('
            bool result = expr();
            if (current_token().type == RPAREN) {
                consume(); // Consume ')'
                return result;
            }
            return false;
        }
        return false; // Invalid token
    }
};

// Función para verificar si una expresión es válida
bool is_valid_expression(const string& expression) {
    vector<Token> tokens = tokenize(expression);
    Parser parser(tokens);
    return parser.parse();
}

int main() {
    vector<string> expressions = {
        "-3+4*5-6",         // Expresión válida
        "7*(6-8)-6",        // Expresión válida
        "(7*9)-5+(4*3)",    // Expresión válida
        "4++5",             // Expresión inválida
        "(7*9-(4*3)"        // Expresión inválida
    };

    for (const string& expr : expressions) {
        if (is_valid_expression(expr)) {
            cout << "Expresión: " << expr << " pertenece a la gramática." << endl;
        } else {
            cout << "Expresión: " << expr << " NO pertenece a la gramática." << endl;
        }
    }

    return 0;
}