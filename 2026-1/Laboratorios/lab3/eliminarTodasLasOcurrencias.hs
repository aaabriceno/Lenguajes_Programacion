--Usando el ejercicio anterior, borre todos las ocurrencias del número ingresado.
eliminarOcurrencias::Int->[Int]->[Int]
eliminarOcurrencias _ [] = []
eliminarOcurrencias numero (x:xs)
    | numero == x = eliminarOcurrencias numero xs
    | otherwise = x:eliminarOcurrencias numero xs
main::IO()
main = print(eliminarOcurrencias 3 [1,2,3,3,3,3,5,6])