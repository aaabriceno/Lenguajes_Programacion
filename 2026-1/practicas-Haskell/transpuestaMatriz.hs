type Matriz = [[Int]]
a ::Matriz
a = [[1,2,3,4],
     [5,6,7,8],
     [9,1,2,3],
     [4,5,6,7]]

obtenerColummna::Matriz->Int->[Int]
obtenerColummna [] _ = []
obtenerColummna (a:as) columna = listaElementosColumna
    where
        elementoColumna = elementoDeLista a columna
        listaElementosColumna = elementoColumna:obtenerColummna as columna

elementoDeLista::[Int]->Int->Int
elementoDeLista [] _ = 0
elementoDeLista (x:_) 0 = x
elementoDeLista (_:xs) indice = elementoDeLista xs (indice-1)


transpuestaMatriz::Matriz->Matriz
transpuestaMatriz [] = []
transpuestaMatriz as = transpuestaDesde as 0

transpuestaDesde::Matriz->Int->Matriz
transpuestaDesde as i = 
  if i >= numeroColumnas as then []
  else obtenerColummna as i: transpuestaDesde as (i+1)

numeroColumnas::Matriz->Int
numeroColumnas [] = 0
numeroColumnas (x:_) = cantidadElementos x


cantidadElementos::[Int]->Int
cantidadElementos [] = 0
cantidadElementos (_:xs) = 1 + cantidadElementos xs

main::IO()
main = print (transpuestaMatriz a)