--Dada una lista de enteros, devuelve la lista de los sucesores de cada entero.
sucesores::[Int]-> [Int]
sucesores [] = []
sucesores (x:xs) = x+1:sucesores xs

main::IO()
main = print(sucesores [1,2,3,4,5])