type Matriz = [[Int]]
a ::Matriz
a = [[1,2,3,4],
     [5,6,7,8],
     [9,1,2,3],
     [4,5,6,7]]

obtenerFilaMatriz::Matriz->Int->[Int]
obtenerFilaMatriz [] _ = []
obtenerFilaMatriz (a:_) 0 = a
obtenerFilaMatriz (_:as) fila = obtenerFilaMatriz as (fila-1)

sumaFila::Matriz->Int->Int
sumaFila [] _ = 0
sumaFila as fila = resultado
    where
        filaResultante = obtenerFilaMatriz as fila
        resultado = sum filaResultante

obtenerColummna::Matriz->Int->[Int]
obtenerColummna [] _ = []
obtenerColummna (a:as) columna = listaElementosColumna
    where
        elementoColumna = elementoDeLista a columna
        listaElementosColumna = elementoColumna:obtenerColummna as columna

sumaColumna::Matriz->Int->Int
sumaColumna [ ] _ = 0
sumaColumna as columna = resultado
    where
        columnaResultante = obtenerColummna as columna
        resultado = sum columnaResultante
        


elementoDeLista::[Int]->Int->Int
elementoDeLista [] _ = 0
elementoDeLista (x:_) 0 = x
elementoDeLista (_:xs) indice = elementoDeLista xs (indice-1)

main :: IO ()
main = do
    print (sumaFila a 3)
    print (sumaColumna a 2)