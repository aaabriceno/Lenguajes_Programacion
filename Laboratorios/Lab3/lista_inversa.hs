--Dada una lista de enteros, devuelve la lista en orden inverso (no usar función reverse).
lista_reversa :: [Int] -> [Int]
lista_reversa [] = []
lista_reversa (x:xs) = (lista_reversa xs) ++ [x]

main :: IO()
main = print (lista_reversa [1,2,3,4,5])