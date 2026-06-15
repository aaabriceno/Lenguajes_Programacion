{-
Cree una función que reciba dos listas ordenadas 
(generar una función de verificación) y devuelva una lista con 
los elementos de ambas listas (lista ordenada).-}

ordenLista :: [Int] -> Bool
ordenLista [] = True
ordenLista [x] = True
ordenLista (x:y:xs)
 | x <= y = ordenLista (y:xs)
 | otherwise = False

dosListasOrdenadas :: [Int] -> [Int] -> [Int]
dosListasOrdenadas xs ys
 | not (ordenLista xs && ordenLista ys) = []
 | otherwise = mezclar xs ys

mezclar :: [Int] -> [Int] -> [Int]
mezclar [] ys = ys
mezclar xs [] = xs
mezclar (x:xs) (y:ys)
 | x <= y = x : mezclar xs (y:ys)
 | otherwise = y : mezclar (x:xs) ys

main::IO()
main = do
    print (dosListasOrdenadas [1,3,5,7,9] [2,4,6,8])
    print (dosListasOrdenadas [2,4,6,8] [1,3,5,7,9])
    print (dosListasOrdenadas [1,6,5,7,9] [2,4,6,8])