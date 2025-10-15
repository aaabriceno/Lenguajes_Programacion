{-
Escribir una función que implemente el algoritmo como descrito abajo.
minsort :: [Int] -> [Int] Para una lista vacía, el algoritmo 
retorna la lista vacía. Para una lista no vacía, el algoritmo min
sort primero calcula el mínimo de la lista, borra el mínimo de la 
lista y luego llama a sí mismo con la lista restante. De la secuencia 
de mínimos calculados construye la lista ordenada.
-}

-- Función principal
minSort :: [Int] -> [Int]
minSort [] = []                         -- Caso base: lista vacía
minSort xs = m : minSort (remove m xs)  -- Toma el mínimo y ordena el resto
  where
    m = minimoLista xs                  -- Calcula el mínimo

-- Calcula el mínimo de una lista manualmente (sin usar minimum)
minimoLista :: [Int] -> Int
minimoLista [x] = x                     -- Si solo hay un elemento, es el mínimo
minimoLista (x:xs)
  | x <= minResto = x                   -- Si x es menor, se queda
  | otherwise     = minResto            -- Si no, el mínimo está en el resto
  where
    minResto = minimoLista xs

-- Elimina solo la primera aparición del elemento dado
remove :: Int -> [Int] -> [Int]
remove _ [] = []
remove n (x:xs)
  | x == n    = xs                      -- Cuando lo encuentra, lo elimina
  | otherwise = x : remove n xs         -- Si no, sigue buscando

-- Programa principal para probar
main :: IO ()
main = do
  print (minSort [4,1,3,2])
  print (minSort [10,5,8,1,9])
  print (minSort [])
