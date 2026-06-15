{-
Cree una función que ingrese dos elementos, una lista de números y un indicador (par o
impar) la cual retorna la lista de los pares/impares según corresponda (no usar función odd
ni even).
-}
parImparLista::[Int] -> String -> [Int]
parImparLista [] _ = []
parImparLista (x:xs) indicador
 | x `mod` 2 == 0 && indicador == "par" = x:parImparLista xs indicador
 | x `mod` 2 /= 0 && indicador == "impar" = x:parImparLista xs indicador
 | otherwise = parImparLista xs indicador

main::IO()
main = do 
        print(parImparLista [1,2,3,4,5,6,7,8] "par")
        print(parImparLista [1,2,3,4,5,6,7,8] "impar")