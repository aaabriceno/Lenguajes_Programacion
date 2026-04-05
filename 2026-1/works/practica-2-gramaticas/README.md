# Practica 2 - Analisis Sintactico en C++

Se implemento la **gramatica 2** del PDF:

```text
<expr>   -> <expr> <opsuma> <term> | <term>
<opsuma> -> + | -
<term>   -> <term> <opmulti> <factor> | <factor>
<opmulti>-> * | /
<factor> -> ( <expr> ) | numero
```

Como la gramatica original tiene recursion izquierda, en el programa se usa una version equivalente apta para un analizador descendente recursivo:

```text
expresion -> termino { (+ | -) termino }*
termino   -> factor { (* | /) factor }*
factor    -> numero | ( expresion )
```

## Compilar

```bash
g++ -std=c++17 -Wall -Wextra -pedantic practica-2-gramaticas/verificador_gramatica.cpp -o practica-2-gramaticas/verificador_gramatica
```

## Ejecutar

```bash
./practica-2-gramaticas/verificador_gramatica
```

Luego ingresa una expresion por linea. El programa:

- indica si la sentencia pertenece o no a la gramatica;
- ignora espacios en blanco;
- muestra el valor calculado cuando la expresion es valida.
- reporta un error si se intenta dividir entre cero.

## Ejemplos del PDF

```text
3+4*5-6
7*(6-8)-6
(7*9)-5+(4*3)
```
