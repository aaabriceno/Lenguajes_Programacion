type Matriz = [[Int]]
a :: Matriz
a = [[1,2,3,4,5],
     [1,2,3,4,5],
     [1,2,3,4,5],
     [1,2,3,4,5]]

sumarLista::[Int]->Int
sumarLista [] = 0
sumarLista as = sum as

sumarMatriz::Matriz->Int
sumarMatriz [] = 0
sumarMatriz (x:xs) = resultado
    where
        resultado = sumarLista x + sumarMatriz xs

