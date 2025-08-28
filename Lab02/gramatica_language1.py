import re

# Definimos un "tokenizador" que divide la entrada en tokens
def tokenize(expression):
    return re.findall(r'\d+|[()+\-*/]', expression)

class Parser:
    def _init_(self, tokens):
        self.tokens = tokens
        self.pos = 0

    def current_token(self):
        return self.tokens[self.pos] if self.pos < len(self.tokens) else None

    def consume(self):
        self.pos += 1

    def expr(self):
        result = self.term()
        while self.current_token() in ('+', '-'):
            op = self.current_token()
            self.consume()  # Consume el operador
            right = self.term()
            if op == '+':
                result += right
            else:
                result -= right
        return result

    def term(self):
        result = self.factor()
        while self.current_token() in ('*', '/'):
            op = self.current_token()
            self.consume()  # Consume el operador
            right = self.factor()
            if op == '*':
                result *= right
            else:
                result /= right
        return result

    def factor(self):
        token = self.current_token()
        if token.isdigit():
            self.consume()  # Consume el número
            return int(token)
        elif token == '(':
            self.consume()  # Consume '('
            result = self.expr()
            if self.current_token() == ')':
                self.consume()  # Consume ')'
                return result
            else:
                raise SyntaxError("Esperaba ')'")
        else:
            raise SyntaxError(f"Símbolo inesperado: {token}")

def is_valid_expression(expression):
    try:
        tokens = tokenize(expression)
        parser = Parser(tokens)
        parser.expr()  # Solo verificamos si la expresión es válida
        return True  # Si no ocurre un error, es válida
    except:
        return False  # Si hay un error, no es válida

# Pruebas con las expresiones proporcionadas
expressions = [
    "3+4*5-6",
    "7*(6-8)-6",
    "(7*9)-5+(4*3)"
]

for expr in expressions:
    if is_valid_expression(expr):
        print(f"Expresión: {expr} pertenece a la gramática.")
    else:
        print(f"Expresión: {expr} NO pertenece a la gramática.")