type Matriz = [[Int]]
a ::Matriz
a = [[11,12,13,14,15],
     [16,17,18,19,20],
     [21,22,23,24,25],
     [26,27,28,29,30]]



elementoLista::[Int]->Int->Int
elementoLista [] _  = 0
elementoLista (x:_) 0 = x
elementoLista (_:xs) indice = elementoLista xs (indice-1)

obtenerFilaMatriz::[[Int]]->Int->[Int]
obtenerFilaMatriz [] _ = []
obtenerFilaMatriz (a:_) 0 = a
obtenerFilaMatriz (_:as) fila = obtenerFilaMatriz as (fila-1)


obtenerElemento::[[Int]]->Int->Int->Int
obtenerElemento [] _ _ = 0
obtenerElemento as fila columna = elementoObtenido
    where
        filaObtenida = obtenerFilaMatriz as fila
        elementoObtenido = elementoLista filaObtenida columna

diagonalMatriz::[[Int]]->[Int]
diagonalMatriz [] = []
diagonalMatriz as = diagonal as 0 0

numeroFilasMatriz::[[Int]]->Int
numeroFilasMatriz [] = 0
numeroFilasMatriz (_:as) = 1 + numeroFilasMatriz as

diagonal::[[Int]]->Int->Int->[Int]
diagonal as fila columna
    | fila >= numeroFilasMatriz as = []
    | otherwise                    = elementoDiagonal : diagonal as (fila+1) (columna+1)
    where
        elementoDiagonal = obtenerElemento as fila columna

main::IO()
main = do
    print (diagonalMatriz a)