{-Dada dos listas del mismo tamaño, devuelva otra 
lista en donde están los valores mínimos de ambas 
listas (comparación por posición)-}

minDeListas:: [Int] -> [Int] -> [Int]
minDeListas [] [] = []
minDeListas (x:xs) (y:ys)
  | x < y     = x : minDeListas xs ys
  | otherwise = y : minDeListas xs ys
main :: IO()
main = print (minDeListas [1,3,0,4,7] [2,2,1,3,6])