--Dada una lista de enteros, devuelve la lista de los sucesores de cada entero.
sucesores_de_numeros :: [Int] -> [Int]
sucesores_de_numeros [] = []
sucesores_de_numeros (x:xs) = x+1 : sucesores_de_numeros xs

main :: IO()
main = print (sucesores_de_numeros [1,2,3,4,5,6])