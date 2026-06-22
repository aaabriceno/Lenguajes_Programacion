type Matriz = [[Int]]
a :: Matriz
a = [[11,12,13,14,15],
     [16,17,18,19,20],
     [21,22,23,24,25],
     [26,27,28,29,30]]

b :: Matriz
b = [[11,12,13,14,15],
     [16,17,18,19,20],
     [21,22,23,24,25],
     [26,27,28,29,30]]


--Para obtener la fila con indice i
obtenerFilaMatriz::[[Int]]->Int->[Int]
obtenerFilaMatriz [] _ = []
obtenerFilaMatriz (a:_) 0 = a
obtenerFilaMatriz (_:as) fila = obtenerFilaMatriz as (fila-1)

--Para obtener la columna con indice j
obtenerColumnaMatriz::[[Int]]->Int->[Int]
obtenerColumnaMatriz [] _ = []
obtenerColumnaMatriz (a:as) columna = listaDeElementosColumna
    where
        elementoColumnaLista = elementoLista a columna
        listaDeElementosColumna = elementoColumnaLista:obtenerColumnaMatriz as columna

--Obtengo el valor de un numero n que tiene indice i en una lista
elementoLista::[Int]->Int->Int
elementoLista [] _  = 0
elementoLista (x:_) 0 = x
elementoLista (_:xs) indice = elementoLista xs (indice-1)

--Obtengo el valor de un numero con fila y columna
obtenerElemento::[[Int]]->Int->Int->Int
obtenerElemento [] _ _ = 0
obtenerElemento as fila columna = elementoObtenido
    where
        filaObtenida = obtenerFilaMatriz as fila
        elementoObtenido = elementoLista filaObtenida columna

--Obtener la cantidad de elemento de una lista
cantidadElementos::[Int]->Int
cantidadElementos [] = 0
cantidadElementos (_:xs) = 1 + cantidadElementos xs 

--Obtener la cantidad filas de una matriz
numeroFilasMatriz::[[Int]]->Int
numeroFilasMatriz [] = 0
numeroFilasMatriz (a:as) = 1 + numeroFilasMatriz as 

--Obtener la cantidad de columnas de una matriz
numeroColumnasMatriz::[[Int]]->Int
numeroColumnasMatriz [] = 0
numeroColumnasMatriz (a:_) = cantidadElementos a

--Multiplicar dos listas y obtener resultado para matriz
multiplicarListas::[Int]->[Int]->Int
multiplicarListas [] _ = 0
multiplicarListas _ [] = 0
multiplicarListas (x:xs) (y:ys) =  x*y + multiplicarListas xs ys

{-Agarra una lista y una matriz y llama a la funcion multiplicarListas
y multiplica la lista con las columnas del la segunda matriz-}
obtenerValoresMatriz::[Int]->[[Int]]->Int->[Int]
obtenerValoresMatriz filaDeMatrizA matrizB indiceColumna =
    if indiceColumna >= numeroColumnasMatriz matrizB then []
    else resultadoMulListas : obtenerValoresMatriz filaDeMatrizA matrizB (indiceColumna+1)
    where
        resultadoMulListas = multiplicarListas filaDeMatrizA columna
        --fila = obtenerFilaMatriz matrizA 0
        columna = obtenerColumnaMatriz matrizB indiceColumna

multiplicarMatrices::[[Int]]->[[Int]]->[[Int]]
multiplicarMatrices [] _ = []
multiplicarMatrices (a:as) (bs) = obtenerValoresMatriz a bs 0: multiplicarMatrices as bs 

main::IO()
main = do
    --print (obtenerFilaMatriz a 1)
    --print (obtenerColumnaMatriz a 1)
    --print (obtenerElemento a 1 1)
    --print (cantidadElementos [12,1,13,2,14])
    print (multiplicarMatrices a b)
