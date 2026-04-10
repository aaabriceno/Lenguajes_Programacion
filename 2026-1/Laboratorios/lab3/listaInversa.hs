--Dada una lista de enteros, devuelve la lista en orden inverso (no usar función reverse).
listaInversa::[Int]->[Int]
listaInversa [] = []
listaInversa (x:xs) = listaInversa xs ++ [x]
--el operador ++ concatena listas por lo que se usa para concatenar el primer elemento
--se va al final de la lista y se llama recursivamente al inicio al resto de la lista.

main::IO()
main = print(listaInversa [9,8,7,6,5,4,3,2,1])