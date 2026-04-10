--Escribir una función que borre la primera ocurrencia de un entero de una lista:
eliminarPrimeraOcurrencia::Int->[Int]->[Int]
eliminarPrimeraOcurrencia _ [] = []
eliminarPrimeraOcurrencia numero (x:xs) 
    | numero == x = xs
    | otherwise = x:eliminarPrimeraOcurrencia numero xs

main::IO()
main = print(eliminarPrimeraOcurrencia 2 [1,2,3,2,1])