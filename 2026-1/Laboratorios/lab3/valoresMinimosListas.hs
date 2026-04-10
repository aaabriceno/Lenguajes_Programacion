--Dada dos listas del mismo tamaño, devuelva otra lista en donde están los valores mínimos de
--ambas listas (comparación por posición)
minimosDeListas::[Int]->[Int]->[Int]
minimosDeListas [] [] = []
minimosDeListas (x:xs) (y:ys)
    | x <= y = x:minimosDeListas xs ys
    --comparo el menor de lista en cada iteracion, si en este caso son iguales 1-1
    --entonces que retorne x si no osea si y es menor y entonces
    | otherwise = y:minimosDeListas xs ys
main::IO()
main = print(minimosDeListas [-20,21,3,43,5,6] [2,3,41,5,61,6])