type Matriz = [[Int]]
a :: Matriz
a = [[1,2,3],[4,5,6],[7,8,9]]


obtenerElementoLista::[Int]->Int->Int
obtenerElementoLista [] _ = 0
obtenerElementoLista  (x:_) 0 = x
obtenerElementoLista  (_:xs) indice = obtenerElementoLista xs (indice-1)

obtenerColumna::[[Int]]->Int->[Int]
obtenerColumna [] _ = []
obtenerColumna (a:as) columna = listaDeElementosColumna
    where
        elementoColumnaLista = obtenerElementoLista a columna
        listaDeElementosColumna = elementoColumnaLista:obtenerColumna as columna

invertirLista::[Int]->[Int]
invertirLista [] = []
invertirLista (x:xs) = invertirLista xs ++ [x]


rotarMatriz::[[Int]]->Int->[[Int]]
rotarMatriz [] _ = []
rotarMatriz as indice
    | indice >= length (head as) = []
    | otherwise = matrizRotada
    where
        columnaMatriz = obtenerColumna as indice
        columnaReves = invertirLista columnaMatriz
        matrizRotada = columnaReves:rotarMatriz as (indice+1)

main::IO()
main = do
    print (rotarMatriz a 0)